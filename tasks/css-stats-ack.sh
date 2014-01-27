#!/bin/bash

## Generate CSS Statistics and determine the health of your css
##
## Usage
## bash /path/to/css-stats-ack.sh
## bash /path/to/css-stats-ack.sh > file.txt
##
## TODO - add support for SCSS
##

## Header
echo
echo '======================================================'
echo ' CSS STATISTICS'
echo '======================================================'
echo

## Files Analyzed
echo '------------------------------------------------------'
echo 'CSS Files Analyzed'
echo '------------------------------------------------------'
find . -iname '*.css' | sort
echo

## Files Size
echo '------------------------------------------------------'
echo 'CSS Files Size'
echo '------------------------------------------------------'
find . -iname '*.css' -print0 | xargs -0 du -hsc | sort -n
echo

## Number of Lines per File
echo '------------------------------------------------------'
echo 'Lines of CSS by File'
echo '------------------------------------------------------'
find . -iname '*.css' -print0 | xargs -0 wc -l | sort -n
echo

## Selector Analysis
##
## TODO - Better REGEX here for more advanced rules and formatting.
## TODO - Check for duplicate selectors
## TODO - Check for media queries and display them all
## TODO - After showing media queries, show number of rule blocks for each of the media queries
## TODO - Check for errors in the visual formatting model (for instance declaring inline-block with float)
##
echo '------------------------------------------------------'
echo 'Selector Analysis'
echo '------------------------------------------------------'
ack -ohi --nogroup --css --match="\{[^\'\"]" | wc -w | xargs echo 'Rule Blocks:'
echo

## Repetitive Property Analysis
echo '------------------------------------------------------'
echo 'Repetitive Property Analysis'
echo '------------------------------------------------------'
ack -ohi --nogroup --css --match="float:" | wc -l | xargs echo 'Float:'
ack -ohi --nogroup --css --match="height:" | wc -l | xargs echo 'Height:'
ack -ohi --nogroup --css --match="width:" | wc -l | xargs echo 'Width:'
ack -ohi --nogroup --css --match="margin-?(top|right|bottom|left)?\s*:" | wc -l | xargs echo 'Margin:'
ack -ohi --nogroup --css --match="padding-?(top|right|bottom|left)?\s*:" | wc -l | xargs echo 'Padding:'
ack -ohi --nogroup --css --match="font-size:" | wc -l | xargs echo 'Font Size:'
ack -ohi --nogroup --css --match="color:" | wc -l | xargs echo 'Color:'
ack -ohi --nogroup --css --match="!important" | wc -l | xargs echo '!important:'
echo

## Color Analysis
##
## TODO - Clean up Color Name Declarations
##        as sometimes characters / whitespace preceding
##        colornames show up in the analysis
## TODO - Fix issue where CSS IDs report back incorrectly
##        as hex values - example #face #cab
##
echo '------------------------------------------------------'
echo 'Color Analysis'
echo '------------------------------------------------------'
echo 'Hex Value Declarations'
ack -ohi --nogroup --css --match="#[0-9a-fA-F]{3,6}" | sort -r | uniq -c | sort -r
echo
echo 'Color Name Declarations'
ack -ohi --nogroup --css --match="(^|[^#\.\-\_])\b(aliceblue|antiquewhite|aqua|aquamarine|azure|beige|bisque|black|blanchedalmond|blue|blueviolet|brown|burlywood|cadetblue|chartreuse|chocolate|coral|cornflowerblue|cornsilk|crimson|cyan|darkblue|darkcyan|darkgoldenrod|darkgray|darkgreen|darkgrey|darkkhaki|darkmagenta|darkolivegreen|darkorange|darkorchid|darkred|darksalmon|darkseagreen|darkslateblue|darkslategray|darkslategrey|darkturquoise|darkviolet|deeppink|deepskyblue|dimgray|dimgrey|dodgerblue|firebrick|floralwhite|forestgreen|fuchsia|gainsboro|ghostwhite|gold|goldenrod|gray|green|greenyellow|grey|honeydew|hotpink|indianred|indigo|ivory|khaki|lavender|lavenderblush|lawngreen|lemonchiffon|lightblue|lightcoral|lightcyan|lightgoldenrodyellow|lightgray|lightgreen|lightgrey|lightpink|lightsalmon|lightseagreen|lightskyblue|lightslategray|lightslategrey|lightsteelblue|lightyellow|lime|limegreen|linen|magenta|maroon|mediumaquamarine|mediumblue|mediumorchid|mediumpurple|mediumseagreen|mediumslateblue|mediumspringgreen|mediumturquoise|mediumvioletred|midnightblue|mintcream|mistyrose|moccasin|navajowhite|navy|oldlace|olive|olivedrab|orange|orangered|orchid|palegoldenrod|palegreen|paleturquoise|palevioletred|papayawhip|peachpuff|peru|pink|plum|powderblue|purple|red|rosybrown|royalblue|saddlebrown|salmon|sandybrown|seagreen|seashell|sienna|silver|skyblue|slateblue|slategray|slategrey|snow|springgreen|steelblue|tan|teal|thistle|tomato|turquoise|violet|wheat|white|whitesmoke|yellow|yellowgreen)\b" | sort -r | uniq -c | sort -r
echo
echo 'RGBA Value Declarations'
ack -ohi --nogroup --css --match="rgba\(.*\)" | sort -r | uniq -c | sort -r
echo
echo 'RGB Value Declarations'
ack -ohi --nogroup --css --match="rgb\(.*\)" | sort -r | uniq -c | sort -r
echo
echo 'HSLA Value Declarations'
ack -ohi --nogroup --css --match="hsla\(.*\)" | sort -r | uniq -c | sort -r
echo
echo 'HSL Value Declarations'
ack -ohi --nogroup --css --match="hsl\(.*\)" | sort -r | uniq -c | sort -r
echo