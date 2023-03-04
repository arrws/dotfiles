-- clear lua's cache,
package.loaded['lush_theme.shway'] = nil

-- include our theme file and pass it to lush to apply
require('lush')(require('lush_theme.xtheme'))

