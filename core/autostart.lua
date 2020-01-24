local awful         =   require("awful")

 local run_on_start_up = {
    "compton -CGb ", -- Equalizer
    "nm-applet", -- NetworkManager Applet
    "redshift-gtk -l 14.45:121.05", -- Redshift
    "light-locker -- Auto lock"
 }

local function run_once(cmd)
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd), false)
end
  
for _, app in ipairs(run_on_start_up) do
    run_once(app)
end
