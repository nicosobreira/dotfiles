/* See LICENSE file for copyright and license details. */

#include <X11/XF86keysym.h>

/* Helper macros for spawning commands */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }
#define CMD(...)   { .v = (const char*[]){ __VA_ARGS__, NULL } }

/* appearance */
#define GAP (5)

static const unsigned int borderpx = 1;   /* border pixel of windows */
static const unsigned int snap     = 32;  /* snap pixel */
static const unsigned int gappih   = GAP;   /* horiz inner gap between windows */
static const unsigned int gappiv   = GAP;   /* vert inner gap between windows */
static const unsigned int gappoh   = GAP;   /* horiz outer gap between windows and screen edge */
static const unsigned int gappov   = GAP;   /* vert outer gap between windows and screen edge */
static const int smartgaps_fact    = 1;   /* gap factor when there is only one client; 0 = no gaps, 3 = 3x outer gaps */
static const int showbar           = 1;   /* 0 means no bar */
static const int topbar            = 1;   /* 0 means bottom bar */

/* Status is to be shown on: -1 (all monitors), 0 (a specific monitor by index), 'A' (active monitor) */
static const int statusmon               = 'A';
static const unsigned int systrayspacing = 2;   /* systray spacing */
static const int showsystray             = 1;   /* 0 means no systray */

/* alt-tab configuration */
static const unsigned int tabmodkey   = 0x40;  /* (Alt) when this key is held down the alt-tab functionality stays active. Must be the same modifier as used to run alttabstart */
static const unsigned int tabcyclekey = 0x17;  /* (Tab) when this key is hit the menu moves one position forward in client stack. Must be the same key as used to run alttabstart */
static const unsigned int tabposy     = 1;     /* tab position on Y axis, 0 = top, 1 = center, 2 = bottom */
static const unsigned int tabposx     = 1;     /* tab position on X axis, 0 = left, 1 = center, 2 = right */
static const unsigned int maxwtab     = 600;   /* tab menu width */
static const unsigned int maxhtab     = 200;   /* tab menu height */

/* Indicators: see patch/bar_indicators.h for options */
static int tagindicatortype   = INDICATOR_TOP_LEFT_SQUARE;
static int tiledindicatortype = INDICATOR_NONE;
static int floatindicatortype = INDICATOR_TOP_LEFT_SQUARE;

static const char *fonts[]    = { "CaskaydiaCove NF:size=12:style=Regular" };
static const char dmenufont[] = "CaskaydiaCove NF:size=12:style=Bold";

static char c000000[] = "#000000"; // placeholder value

#define COLOR_TEXT      "#cdd6f4"
#define COLOR_BASE      "#1e1e2e"
#define COLOR_GRAY      "#313244"
#define COLOR_YELLOW    "#f9e2af"
#define COLOR_MAIN      "#cba6f7"
#define COLOR_BLUE      "#89b4f1"
#define COLOR_SECONDARY "#a6e3a1"
#define COLOR_RED       "#f38ba8"

static char normfgcolor[]          = COLOR_TEXT;
static char normbgcolor[]          = COLOR_BASE;
static char normbordercolor[]      = COLOR_GRAY;
static char normfloatcolor[]       = COLOR_YELLOW;

static char selfgcolor[]           = COLOR_GRAY;
static char selbgcolor[]           = COLOR_MAIN;
static char selbordercolor[]       = COLOR_MAIN;
static char selfloatcolor[]        = COLOR_MAIN;

static char titlenormfgcolor[]     = COLOR_TEXT;
static char titlenormbgcolor[]     = COLOR_BASE;
static char titlenormbordercolor[] = COLOR_GRAY;
static char titlenormfloatcolor[]  = COLOR_YELLOW;

static char titleselfgcolor[]      = COLOR_BASE;
static char titleselbgcolor[]      = COLOR_MAIN;
static char titleselbordercolor[]  = COLOR_MAIN;
static char titleselfloatcolor[]   = COLOR_MAIN;

static char tagsnormfgcolor[]      = COLOR_MAIN;
static char tagsnormbgcolor[]      = COLOR_BASE;
static char tagsnormbordercolor[]  = COLOR_GRAY;
static char tagsnormfloatcolor[]   = COLOR_YELLOW;

static char tagsselfgcolor[]       = COLOR_SECONDARY;
static char tagsselbgcolor[]       = COLOR_BASE;
static char tagsselbordercolor[]   = COLOR_GRAY;
static char tagsselfloatcolor[]    = COLOR_YELLOW;

static char hidnormfgcolor[]       = COLOR_MAIN;
static char hidnormbgcolor[]       = COLOR_BASE;

static char hidselfgcolor[]        = COLOR_SECONDARY;
static char hidselbgcolor[]        = COLOR_BASE;

static char urgfgcolor[]           = COLOR_MAIN;
static char urgbgcolor[]           = COLOR_BASE;
static char urgbordercolor[]       = COLOR_RED;
static char urgfloatcolor[]        = COLOR_YELLOW;

static char *colors[][ColCount] = {
	/*                       fg                bg                border                float */
	[SchemeNorm]         = { normfgcolor,      normbgcolor,      normbordercolor,      normfloatcolor },
	[SchemeSel]          = { selfgcolor,       selbgcolor,       selbordercolor,       selfloatcolor },
	[SchemeTitleNorm]    = { titlenormfgcolor, titlenormbgcolor, titlenormbordercolor, titlenormfloatcolor },
	[SchemeTitleSel]     = { titleselfgcolor,  titleselbgcolor,  titleselbordercolor,  titleselfloatcolor },
	[SchemeTagsNorm]     = { tagsnormfgcolor,  tagsnormbgcolor,  tagsnormbordercolor,  tagsnormfloatcolor },
	[SchemeTagsSel]      = { tagsselfgcolor,   tagsselbgcolor,   tagsselbordercolor,   tagsselfloatcolor },
	[SchemeHidNorm]      = { hidnormfgcolor,   hidnormbgcolor,   c000000,              c000000 },
	[SchemeHidSel]       = { hidselfgcolor,    hidselbgcolor,    c000000,              c000000 },
	[SchemeUrg]          = { urgfgcolor,       urgbgcolor,       urgbordercolor,       urgfloatcolor },
};

/* Tags
 * In a traditional dwm the number of tags in use can be changed simply by changing the number
 * of strings in the tags array. This build does things a bit different which has some added
 * benefits. If you need to change the number of tags here then change the NUMTAGS macro in dwm.c.
 *
 * Examples:
 *
 *  1) static char *tagicons[][NUMTAGS*2] = {
 *         [DEFAULT_TAGS] = { "1", "2", "3", "4", "5", "6", "7", "8", "9", "A", "B", "C", "D", "E", "F", "G", "H", "I" },
 *     }
 *
 *  2) static char *tagicons[][1] = {
 *         [DEFAULT_TAGS] = { "•" },
 *     }
 *
 * The first example would result in the tags on the first monitor to be 1 through 9, while the
 * tags for the second monitor would be named A through I. A third monitor would start again at
 * 1 through 9 while the tags on a fourth monitor would also be named A through I. Note the tags
 * count of NUMTAGS*2 in the array initialiser which defines how many tag text / icon exists in
 * the array. This can be changed to *3 to add separate icons for a third monitor.
 *
 * For the second example each tag would be represented as a bullet point. Both cases work the
 * same from a technical standpoint - the icon index is derived from the tag index and the monitor
 * index. If the icon index is is greater than the number of tag icons then it will wrap around
 * until it an icon matches. Similarly if there are two tag icons then it would alternate between
 * them. This works seamlessly with alternative tags and alttagsdecoration patches.
 */
static char *tagicons[][NUMTAGS] =
{
	[DEFAULT_TAGS]        = { "", "󰖟", "󰺷", ""},
	[ALTERNATIVE_TAGS]    = { "A", "B", "C", "D" },
	[ALT_TAGS_DECORATION] = { "<1>", "<2>", "<3>", "<4>" },
};

/* There are two options when it comes to per-client rules:
 *  - a typical struct table or
 *  - using the RULE macro
 *
 * A traditional struct table looks like this:
 *    // class      instance  title  wintype  tags mask  isfloating  monitor
 *    { "Gimp",     NULL,     NULL,  NULL,    1 << 4,    0,          -1 },
 *    { "Firefox",  NULL,     NULL,  NULL,    1 << 7,    0,          -1 },
 *
 * The RULE macro has the default values set for each field allowing you to only
 * specify the values that are relevant for your rule, e.g.
 *
 *    RULE(.class = "Gimp", .tags = 1 << 4)
 *    RULE(.class = "Firefox", .tags = 1 << 7)
 *
 * Refer to the Rule struct definition for the list of available fields depending on
 * the patches you enable.
 */
static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 *	WM_WINDOW_ROLE(STRING) = role
	 *	_NET_WM_WINDOW_TYPE(ATOM) = wintype
	 */
	RULE(.wintype = WTYPE "DIALOG", .isfloating = 1)
	RULE(.wintype = WTYPE "UTILITY", .isfloating = 1)
	RULE(.wintype = WTYPE "TOOLBAR", .isfloating = 1)
	RULE(.wintype = WTYPE "SPLASH", .isfloating = 1)
	
	/* Browers */
	RULE(.class = "firefox", .tags = 1 << 1)
	RULE(.class = "Vivaldi", .tags = 1 << 1)

	/* Games */
	RULE(.class = "retroarch", .tags = 1 << 2)
	RULE(.class = "steam", .tags = 1 << 2)

	/* Notes */
	RULE(.class = "obsidian", .tags = 1 << 3)
	RULE(.class = "Gimp", .tags = 1 << 3)

};

/* Bar rules allow you to configure what is shown where on the bar, as well as
 * introducing your own bar modules.
 *
 *    monitor:
 *      -1  show on all monitors
 *       0  show on monitor 0
 *      'A' show on active monitor (i.e. focused / selected) (or just -1 for active?)
 *    bar - bar index, 0 is default, 1 is extrabar
 *    alignment - how the module is aligned compared to other modules
 *    widthfunc, drawfunc, clickfunc - providing bar module width, draw and click functions
 *    name - does nothing, intended for visual clue and for logging / debugging
 */
static const BarRule barrules[] = {
	/* monitor   bar    alignment         widthfunc                 drawfunc                clickfunc                hoverfunc                name */
	{ -1,        0,     BAR_ALIGN_LEFT,   width_tags,               draw_tags,              click_tags,              hover_tags,              "tags" },
	{  0,        0,     BAR_ALIGN_RIGHT,  width_systray,            draw_systray,           click_systray,           NULL,                    "systray" },
	{ -1,        0,     BAR_ALIGN_LEFT,   width_ltsymbol,           draw_ltsymbol,          click_ltsymbol,          NULL,                    "layout" },
	{ statusmon, 0,     BAR_ALIGN_RIGHT,  width_status2d,           draw_status2d,          click_status2d,          NULL,                    "status2d" },
	{ -1,        0,     BAR_ALIGN_NONE,   width_awesomebar,         draw_awesomebar,        click_awesomebar,        NULL,                    "awesomebar" },
};

/* layout(s) */
static const float mfact        = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster        = 1;    /* number of clients in master area */
static const int resizehints    = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol  arrange function */
	{ "[T]",   tile },    /* first entry is default */
	{ "[F]",   NULL },    /* no layout function means floating behavior */
	{ "[M]",   monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {
	"dmenu_run",
	"-m", dmenumon,
	"-fn", dmenufont,
	"-nb", normbgcolor,
	"-nf", normfgcolor,
	"-sb", selbgcolor,
	"-sf", selfgcolor,
	NULL
};

static const char *termcmd[]           = { "alacritty", NULL };

static const char *printScreenCmd[]    = { "flameshot", "gui", NULL };
static const char *browserCmd[]        = { "vivaldi-stable", NULL };

static const Key keys[] = {
	/* modifier                     key            function                argument */
	{ MODKEY,           XK_p,                     spawn,          SHCMD("$HOME/.config/rofi/launcher.sh") },
	{ MODKEY|ShiftMask, XK_p,                     spawn,          {.v = dmenucmd } },
	{ MODKEY,           XK_Return,                spawn,          {.v = termcmd } },
	{ MODKEY,           XK_j,                     focusstack,     {.i = +1 } },
	{ MODKEY,           XK_k,                     focusstack,     {.i = -1 } },
	{ MODKEY,           XK_i,                     incnmaster,     {.i = +1 } },
	{ MODKEY,           XK_d,                     incnmaster,     {.i = -1 } },
	{ MODKEY,           XK_h,                     setmfact,       {.f = -0.02} },
	{ MODKEY,           XK_l,                     setmfact,       {.f = +0.02} },
	{ MODKEY,           XK_z,                     zoom,           {0} },
	{ MODKEY,           XK_Tab,                   view,           {0} },

	{ MODKEY,           XK_c,                     killclient,     {0} },
	{ MODKEY,           XK_F4,                    killclient,     {0} },

	{ MODKEY,           XK_t,                     setlayout,      {.v = &layouts[0]} },
	{ MODKEY,           XK_f,                     setlayout,      {.v = &layouts[1]} },
	{ MODKEY,           XK_m,                     setlayout,      {.v = &layouts[2]} },
	{ MODKEY,           XK_space,                 setlayout,      {0} },
	{ MODKEY|ShiftMask, XK_space,                 togglefloating, {0} },
	{ MODKEY,           XK_0,                     view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask, XK_0,                     tag,            {.ui = ~0 } },
	{ MODKEY,           XK_comma,                 focusmon,       {.i = -1 } },
	{ MODKEY,           XK_period,                focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask, XK_comma,                 tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask, XK_period,                tagmon,         {.i = +1 } },
	{ MODKEY,           XK_BackSpace,             zoom,           {0} },
	{ MODKEY,           XK_b,                     spawn,          {.v = browserCmd } },
	{ MODKEY|ShiftMask, XK_b,                     togglebar,      {0} },

	/* Custom Keys */
	{ 0,                XK_Print,                 spawn,          {.v = printScreenCmd } },
	{ 0,                XF86XK_AudioMute,         spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ toggle; kill -44 $(pidof dwmblocks)") },
	{ 0,                XF86XK_AudioLowerVolume,  spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ false; pactl set-sink-volume @DEFAULT_SINK@ -3%; kill -44 $(pidof dwmblocks)") },
	{ 0,                XF86XK_AudioRaiseVolume,  spawn,          SHCMD("pactl set-sink-mute @DEFAULT_SINK@ false; pactl set-sink-volume @DEFAULT_SINK@ +3%; kill -44 $(pidof dwmblocks)")  },

	{ 0,                XF86XK_MonBrightnessUp,   spawn,          SHCMD("brightnessctl set 5%+; kill -45 $(pidof dwmblocks)") },
	{ 0,                XF86XK_MonBrightnessDown, spawn,          SHCMD("brightnessctl set 5%-; kill -45 $(pidof dwmblocks)") },

	{ MODKEY,           XK_q,                     quit,           {0} },
	{ MODKEY|ShiftMask, XK_q,                     spawn,          SHCMD("$HOME/.config/rofi/powermenu.sh") },

	TAGKEYS(            XK_1,                     0)
	TAGKEYS(            XK_2,                     1)
	TAGKEYS(            XK_3,                     2)
	TAGKEYS(            XK_4,                     3)
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask           button          function        argument */
	{ ClkLtSymbol,          0,                   Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,                   Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,                   Button1,        togglewin,      {0} },
	{ ClkWinTitle,          0,                   Button3,        showhideclient, {0} },
	{ ClkWinTitle,          0,                   Button2,        zoom,           {0} },
	{ ClkStatusText,        0,                   Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,              Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,              Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,              Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,                   Button1,        view,           {0} },
	{ ClkTagBar,            0,                   Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,              Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,              Button3,        toggletag,      {0} },
};

