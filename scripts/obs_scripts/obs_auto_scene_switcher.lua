obs = obslua

function script_description()
	return "Automatically switch scenes based on the active window class."
end

function switch_scene(scene_name)
	local scene = obs.obs_get_scene_by_name(scene_name)
	if scene then
		obs.obs_frontend_set_current_scene(scene)
		obs.obs_scene_release(scene)
	end
end

function check_active_window()
	local handle = io.popen("xdotool getactivewindow getwindowclass")
	local active_window_class = handle:read("*a")
	handle:close()

	active_window_class = active_window_class:gsub("%s+", "") -- Trim whitespace

	if active_window_class == "chromium" then
		switch_scene("Chrome Scene") -- Replace with your Chrome scene name
	elseif active_window_class == "kitty" then
		switch_scene("Terminal Scene") -- Replace with your Terminal scene name
	end
end

function script_update(settings)
	obs.timer_add(check_active_window, 1000) -- Check every second
end

function script_unload()
	obs.timer_remove(check_active_window)
end
