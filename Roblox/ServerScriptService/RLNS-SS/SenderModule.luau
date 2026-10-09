local Functions = {
	Sender = function(event, player, author, templatename, title, text, duration)
		if not event or not player then return end
		event:FireClient(player, author, templatename, title, text, duration)
		print(player, author, templatename, title, text, duration)
	end
}

return Functions

