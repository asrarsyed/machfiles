#### How to build a custom version of iosevka font?

1. Clone the iosevka repository: `git clone --depth 1 https://github.com/be5invis/Iosevka.git`
2. Create a file named `private-build-plans.toml` and paste there the configuration from [`private-build-plans.toml`](./private-build-plans.toml)
3. Install both [NodeJS](https://nodejs.org/en) (>= 18.0.0) and [ttfautohint](https://freetype.org/ttfautohint/) (the utility which iosevka uses to build itself from scratch)
4. Run `npm i`
5. Run `npm run build -- ttf-unhinted::iosevka-custom`

As soon as the font is created, it'll appear in `dist` folder within the cloned repository