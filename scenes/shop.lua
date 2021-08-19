local scene = {}

function scene.load()
	
end

function scene.unload()
	
end

function scene.update(delta_time)
end

function scene.control_button(command)
	if command == Command.Confirm then
		
	elseif command == Command.Deny or command == Command.Menu then
		Scene.GoBack()
	end
end

function scene.control_axis(x_axis, y_axis)
end

function scene.draw()
end

return scene
