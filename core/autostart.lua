local r = require("core.runonce")

 local run_on_start_up = {
    "compton -CGb ", -- Equalizer
    "nm-applet", -- NetworkManager Applet
    "redshift-gtk", -- Redshift
    "light-locker -- Auto lock"
 }

  
for _, app in ipairs(run_on_start_up) do
    r.run(app)
end
