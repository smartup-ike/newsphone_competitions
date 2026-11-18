"""Generate the number images for a new app (icon, splash logo, app-bar logo).

Same layout and proportions as the 14614 images, with your own colors.

Needs Pillow and the Montserrat Italic variable font (OFL, free):
  https://github.com/google/fonts/raw/main/ofl/montserrat/Montserrat-Italic%5Bwght%5D.ttf

Usage:
  python3 tool/generate_app_images.py --number 14800 \
      --background "#232323" --foreground "#CC5500" \
      --font /path/to/Montserrat-Italic.ttf --out flavors/app14800

Writes:
  <out>/source/icon.png         2048x2048  (launcher icon)
  <out>/source/splash_logo.png   600x600   (splash centre image)
  <out>/bundled/app_logo.png     371x101   (app bar + About page)
"""
import argparse
import os

from PIL import Image, ImageDraw, ImageFont

# (canvas size, max number box) measured from the 14614 images.
TARGETS = {
    'source/icon.png': ((2048, 2048), (1950, 504)),
    'source/splash_logo.png': ((600, 600), (390, 100)),
    'bundled/app_logo.png': ((371, 101), (331, 91)),
}


def render_number(text, font_path, color):
    font = ImageFont.truetype(font_path, 800)
    font.set_variation_by_name('Black Italic')
    left, top, right, bottom = font.getbbox(text)
    img = Image.new('RGBA', (right - left + 40, bottom - top + 40), (0, 0, 0, 0))
    ImageDraw.Draw(img).text((20 - left, 20 - top), text, font=font, fill=color)
    return img.crop(img.getbbox())


def main():
    p = argparse.ArgumentParser()
    p.add_argument('--number', required=True)
    p.add_argument('--background', required=True)
    p.add_argument('--foreground', required=True)
    p.add_argument('--font', required=True)
    p.add_argument('--out', required=True)
    a = p.parse_args()

    number = render_number(a.number, a.font, a.foreground)
    for rel, ((cw, ch), (bw, bh)) in TARGETS.items():
        scale = min(bw / number.width, bh / number.height)
        n = number.resize((round(number.width * scale), round(number.height * scale)), Image.LANCZOS)
        canvas = Image.new('RGBA', (cw, ch), a.background)
        canvas.alpha_composite(n, ((cw - n.width) // 2, (ch - n.height) // 2))
        path = os.path.join(a.out, rel)
        os.makedirs(os.path.dirname(path), exist_ok=True)
        canvas.convert('RGB').save(path)
        print('wrote', path, canvas.size)


if __name__ == '__main__':
    main()
