"""Qutebrowser configuration"""
from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401,E501 pylint: disable=unused-import
from qutebrowser.config.config import ConfigContainer  # noqa: F401,E501 pylint: disable=unused-import
config = config  # type: ConfigAPI # noqa: F821 pylint: disable=E0602,C0103
c = c  # type: ConfigContainer # noqa: F821 pylint: disable=E0602,C0103

# don't use autoconfig.yml
config.load_autoconfig()

# always restore opened sites when opening qutebrowser
c.auto_save.session = True
c.session.lazy_restore = True

# get rid of the titlebar
c.window.hide_decoration = True

# search engine config
c.url.searchengines = \
        {'DEFAULT': 'https://www.google.com/search?q={}',
         'n': 'https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={}',
         'y': 'https://www.youtube.com/results?search_query={}'}
c.content.pdfjs = True

# enter insert mode on load if input element is present
c.input.insert_mode.auto_load = False
c.input.insert_mode.leave_on_load = False

# tabs
c.tabs.title.format = '{current_title}'
c.colors.tabs.selected.even.fg = "red"
c.colors.tabs.selected.odd.fg = "red"
c.colors.tabs.selected.even.bg = "pink"
c.colors.tabs.selected.odd.bg = "pink"

# keybindings
config.bind("<f12>", "inspector")
config.bind("zz", "zoom")
config.bind("zi", "zoom-in")
config.bind("zo", "zoom-out")

config.unbind("J")
config.unbind("K")
config.bind("J", "tab-prev")
config.bind("K", "tab-next")

config.unbind("d")
config.bind("x", "tab-close")
config.bind("X", "undo")

config.unbind("u")
config.bind("u", "scroll-page 0 -0.5")
config.bind("d", "scroll-page 0 0.5")

config.bind("tp", "open -p")

# to get to login page (e.g. airport/hotel)
# source: https://github.com/noctuid/dotfiles/blob/master/browsing/.config/qutebrowser/config.py
# ../../.local/share/qutebrowser/userscripts/open-default-gateway
# config.bind("'z", ':spawn --userscript open-default-gateway')

# prevent brief white flashes on page load
# source: https://www.reddit.com/r/qutebrowser/comments/h7s27u/dark_mode_white_flashes/
config.set('colors.webpage.preferred_color_scheme', 'dark')
config.set('colors.webpage.bg', 'black')
config.set('colors.webpage.darkmode.enabled', True)
