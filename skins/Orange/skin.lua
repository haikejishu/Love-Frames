--[[------------------------------------------------
	-- Love Frames - A GUI library for LOVE --
	-- Copyright (c) 2013 Kenny Shields --
--]]------------------------------------------------

-- skin table
local skin = {}

-- skin info (you always need this in a skin)
skin.name = "Orange"
skin.author = "Nikolai Resokav"
skin.version = "1.0"
skin.base = "Blue"
skin.imagedir = false

local smallfont = love.graphics.newFont(10)
local imagebuttonfont = love.graphics.newFont(15)
local bordercolor = {143, 143, 143, 255}

-- controls 
skin.controls = {}

-- frame
skin.controls.frame_body_color                      = {232, 232, 232, 255}
skin.controls.frame_name_color                      = {255, 255, 255, 255}
skin.controls.frame_name_font                       = smallfont

-- button
skin.controls.button_text_down_color                = {255, 255, 255, 255}
skin.controls.button_text_nohover_color             = {0, 0, 0, 200}
skin.controls.button_text_hover_color               = {255, 255, 255, 255}
skin.controls.button_text_nonclickable_color        = {0, 0, 0, 100}
skin.controls.button_text_font                      = smallfont

-- imagebutton
skin.controls.imagebutton_text_down_color           = {255, 255, 255, 255}
skin.controls.imagebutton_text_nohover_color        = {255, 255, 255, 200}
skin.controls.imagebutton_text_hover_color          = {255, 255, 255, 255}
skin.controls.imagebutton_text_font                 = imagebuttonfont

-- closebutton
skin.controls.closebutton_body_down_color           = {255, 255, 255, 255}
skin.controls.closebutton_body_nohover_color        = {255, 255, 255, 255}
skin.controls.closebutton_body_hover_color          = {255, 255, 255, 255}

-- progressbar
skin.controls.progressbar_body_color                = {255, 255, 255, 255}
skin.controls.progressbar_text_color                = {0, 0, 0, 255}
skin.controls.progressbar_text_font                 = smallfont

-- list
skin.controls.list_body_color                       = {232, 232, 232, 255}

-- scrollarea
skin.controls.scrollarea_body_color                 = {200, 200, 200, 255}

-- scrollbody
skin.controls.scrollbody_body_color                 = {0, 0, 0, 0}

-- panel
skin.controls.panel_body_color                      = {232, 232, 232, 255}

-- tabpanel
skin.controls.tabpanel_body_color                   = {232, 232, 232, 255}

-- tabbutton
skin.controls.tab_text_nohover_color                = {0, 0, 0, 200}
skin.controls.tab_text_hover_color                  = {255, 255, 255, 255}
skin.controls.tab_text_font                         = smallfont

-- multichoice
skin.controls.multichoice_body_color                = {240, 240, 240, 255}
skin.controls.multichoice_text_color                = {0, 0, 0, 255}
skin.controls.multichoice_text_font                 = smallfont

-- multichoicelist
skin.controls.multichoicelist_body_color            = {240, 240, 240, 200}

-- multichoicerow
skin.controls.multichoicerow_body_nohover_color     = {240, 240, 240, 255}
skin.controls.multichoicerow_body_hover_color       = {255, 153, 0, 255}
skin.controls.multichoicerow_text_nohover_color     = {0, 0, 0, 150}
skin.controls.multichoicerow_text_hover_color       = {255, 255, 255, 255}
skin.controls.multichoicerow_text_font              = smallfont

-- tooltip
skin.controls.tooltip_body_color                    = {255, 255, 255, 255}

-- textinput
skin.controls.textinput_body_color                  = {240, 240, 240, 255}
skin.controls.textinput_indicator_color             = {0, 0, 0, 255}
skin.controls.textinput_text_normal_color           = {0, 0, 0, 255}
skin.controls.textinput_text_selected_color         = {255, 255, 255, 255}
skin.controls.textinput_highlight_bar_color         = {51, 204, 255, 255}

-- slider
skin.controls.slider_bar_outline_color              = {220, 220, 220, 255}

-- checkbox
skin.controls.checkbox_body_color                   = {255, 255, 255, 255}
skin.controls.checkbox_check_color                  = {255, 153, 0, 255}
skin.controls.checkbox_text_font                    = smallfont

-- collapsiblecategory
skin.controls.collapsiblecategory_text_color        = {0, 0, 0, 255}

-- columnlist
skin.controls.columnlist_body_color                 = {232, 232, 232, 255}

-- columlistarea
skin.controls.columnlistarea_body_color             = {232, 232, 232, 255}

-- columnlistheader
skin.controls.columnlistheader_text_down_color      = {255, 255, 255, 255}
skin.controls.columnlistheader_text_nohover_color   = {0, 0, 0, 200}
skin.controls.columnlistheader_text_hover_color     = {255, 255, 255, 255}
skin.controls.columnlistheader_text_font            = smallfont

-- columnlistrow
skin.controls.columnlistrow_body1_color             = {245, 245, 245, 255}
skin.controls.columnlistrow_body2_color             = {255, 255, 255, 255}
skin.controls.columnlistrow_body_selected_color     = {255, 153, 0, 255}
skin.controls.columnlistrow_body_hover_color        = {255, 173, 51, 255}
skin.controls.columnlistrow_text_color              = {100, 100, 100, 255}
skin.controls.columnlistrow_text_hover_color        = {255, 255, 255, 255}
skin.controls.columnlistrow_text_selected_color     = {255, 255, 255, 255}

-- modalbackground
skin.controls.modalbackground_body_color            = {255, 255, 255, 100}

-- linenumberspanel
skin.controls.linenumberspanel_text_color           = {100, 100, 100, 255}
skin.controls.linenumberspanel_body_color			= {200, 200, 200, 255}

-- register the skin
loveframes.skins.Register(skin)