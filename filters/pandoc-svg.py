#! /usr/bin/python3

__author__ = "marineotter"

import mimetypes
import subprocess
import os
from pathlib import Path
import sys
from pandocfilters import toJSONFilter, Image
from jinja2 import Template
import shutil


template = Template('''
<html>
    <head>
        <script>
            function init() {
                const element = document.getElementById('targetsvg');
                const positionInfo = element.getBoundingClientRect();
                const height = positionInfo.height + 1;
                const width = positionInfo.width + 1;
                const style = document.createElement('style');
                style.innerHTML = `html{margin: 0; padding: 0;} body{margin: 0; padding: 0;} img{margin: 0; padding: 0;} @page {margin: 0; padding: 0; size: ${width}px ${height}px}`;
                document.head.appendChild(style);
            }
            window.onload = init;
        </script>
    </head>
    <body>
        <img id="targetsvg" src="{{ svgpath }}">
    </body>
</html>
''')


fmt_to_option = {
    "latex": ("--export-filename", "pdf")
}


def svg_to_any(key, value, fmt, meta):
    if key == 'Image':
        attrs, alt, [src, title] = value
        mimet, _ = mimetypes.guess_type(src)
        option = fmt_to_option.get(fmt)
        if mimet == 'image/svg+xml' and option:
            out_fpath = Path("/temp/") / \
                Path(src).with_suffix(f'.{option[1]}')
            svg_tmpfpath = out_fpath.with_suffix('.svg')
            try:
                mtime = os.path.getmtime(str(out_fpath))
            except OSError:
                mtime = -1
            if mtime < os.path.getmtime(src):
                if os.path.isfile(out_fpath):
                    os.remove(out_fpath)
                os.makedirs(out_fpath.parent, exist_ok=True)
                tmp_html = out_fpath.with_suffix(".html")
                shutil.copyfile(src, svg_tmpfpath)
                sys.stderr.write(f"Generating { str(out_fpath) }\n")
                with open(tmp_html, "w") as wf:
                    wf.write(template.render(svgpath=svg_tmpfpath.name))
                cmd_line = ['chromium-browser', '--no-sandbox', '--headless', '--disable-gpu',
                            f'--print-to-pdf={str(out_fpath)}', str(tmp_html)]
                sys.stderr.write(f"Running { ' '.join(cmd_line) }\n")
                subprocess.call(cmd_line,
                                stdout=subprocess.DEVNULL,
                                stderr=subprocess.DEVNULL)
                sys.stderr.write("Complete\n")
            if attrs:
                return Image(attrs, alt, [str(out_fpath), title])
            else:
                return Image(alt, [str(out_fpath), title])


if __name__ == "__main__":
    toJSONFilter(svg_to_any)
