#!/usr/bin/awk -f
# Assumptions: the data is evenly spaced along the x-axis

function hastitle() {
	for (i = 1; i <= NF; i++) {
		if ($i ~ /[^-0-9.]/) {
			return 1
		}
	}
	return 0
}

function normalise(	delta) {
	delta = 1
	for (i = 1; i <= NF; i++) {
		for (j = 1; j <= NR; j++) {
            if (a[i, j] > delta) {
                delta = a[i, j]
            }
        }
    }
	for (i = 1; i <= NF; i++) {
		for (j = 1; j <= NR; j++) {
		    a[i, j] /= delta
		}
	}
}

# internal coordinates to svg coordinates
function point(x, y) {
	x = x * (chart_width - 2 * xmargin) + xmargin
	y = (height - 2 * ymargin) - y * (height - 2 * ymargin) + ymargin
	return sprintf("%u,%u", x, y)
}

function line(i) {
	printf "  <polyline stroke='%s%s' stroke-width='1.5' fill='none'", color[i], alpha
	printf " points='"

    if (NR > x_step) {
        x_step = NR
    }

	for (j = 1; j <= NR; j++) {
		printf "%s ", point((j - 1) / x_step, a[i, j])
	}

	printf "'/>\n"
}

function circles(i) {
	for (j = 1; j <= NR; j++) {
		p = point((j - 1) / NR, a[i, j])
		split(p, q, ",")
		printf "  <circle cx='%u' cy='%u' r='1.2' fill='%s%s' stroke='%s%s'/>\n",
			q[1], q[2], color[i], alpha, color[i], alpha
	}
}

function legend_text(i, title) {
	printf "  <g transform='translate(%u %u)'>\n", chart_width + gutter, i * line_height
	printf "    <circle cx='%d' cy='%d' r='3.5' fill='%s' stroke='%s'/>\n",
		-10, -line_height / 2 + 5, color[i], color[i]
	printf "    <text style='%s' xml:space='preserve'>%-*s</text>\n",
		sprintf("fill: %s; font-size: %upx; font-family: mono", fg, font_size),
		(title_width > 0) ? title_width + 1 : 0, title
	printf "  </g>\n"
}

function display() {
	print "<?xml version='1.0'?>"
	printf "<svg xmlns='%s' width='%u' height='%u' version='1.1'>\n",
		"http://www.w3.org/2000/svg",
		chart_width + gutter + legend_width, height

	title_width = 0
	for (i = 1; i <= NF; i++) {
		if (length(title[i]) > title_width) {
			title_width = length(title[i])
		}
	}

	for (i = 1; i <= NF; i++) {
		line(i)
		# circles(i)
	}

	if (length(title)) {
		for (i = 1; i <= NF; i++) {
			legend_text(i, title[i])
		}
	}
	print "</svg>"
}

NR == 1 {
	if (hastitle()) {
		for (i = 1; i <= NF; i++) {
			title[i] = $i
		}
		NR--
		next
	}
}

{
	for (i = 1; i <= NF; i++) {
		a[i, NR] = $i
	}
}

END {
	fg    = "#ffffff"
	alpha = "ff"
	color[1] = "#8dd3c7"
	color[2] = "#ffffd3"
	color[3] = "#bebada"
	color[4] = "#fb8072"
	color[5] = "#80b1d3"
	color[6] = "#fdb462"
	color[7] = "#b3de69"
	color[8] = "#fccde5"
	color[9] = "#d9d9d9"
	color[10] = fg

	if (NF == 1) {
		color[1] = fg
	}

	if (NF > length(color)) {
		print "too many fields" >> "/dev/stderr"
		exit 1
	}

	chart_width=600
	legend_width=100
	height=200
	xmargin=10
	ymargin=5
	gutter=10
	font_size=10
	line_height=16
    x_step = 20

	# the data is scaled 0..1 for our internal coordinate space
	normalise()
	display()
}

