return function(roactData, pluginJanitor)
	local Interface = { }

	Interface.roactData = roactData
	Interface.janitor = pluginJanitor

	Interface.roactData.Callbacks = { }

	function Interface:Update()
		
	end

	function Interface.new()
		

		Interface.roactData.init = true
	end

	return Interface.new()
end