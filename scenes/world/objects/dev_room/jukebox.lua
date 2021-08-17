local obj = {
	id = 6,
	animation = newAnimation(love.graphics.newImage("assets/world/objects/dev_room/jukebox.png"), 48, 96, 0.3, 3),
	position = {},
	width = 1,
	height = 2,

	physics = {
		size = {
			x = 48,
			y = 96
		},
		offset = {
			x = 24,
			y = 48
		}
	}
}

function obj:init(initData)
	self.body = love.physics.newBody(initData.world, self.position.x, self.position.y, "static")
	self.shape = love.physics.newRectangleShape(self.physics.offset.x, self.physics.offset.y, self.physics.size.x, self.physics.size.y)
	self.fixture = love.physics.newFixture(self.body, self.shape)
	self.fixture:setUserData(self)
	
	self.infoText = "Do you wanna listen some song?"
end

function obj:onStartCollide(movable)
	if not movable.character or movable.character.name ~= "Hero" then
		return nil
	end

	return { 
		type = "show_info",
		text = self.infoText,
		onConfirm = function()
			local possibleReplicas = {
				{ -- БГ "Время Н"
					"Позвольте мне прервать ваши вечные споры,",
					"Позвольте расшатать скрепы и опоры.",
					"Время беспощадно: оно как волчица.",
					"Вот мы сидим здесь, а оно мчится.",
		
					"Ох, бы жить моей душе на горе с богами,",
					"А ей играют в футбол сапогами,",
					"Лезут как хотят — куда ж она денется.",
					"А душа, как шахид, возьмёт — и наеб*нится.",
		
					"Как мы здесь живём — великая тайна.",
					"Все кричат: \"вира\", а выходит \"майна\".",
					"Бился лбом в бетон,",
					"Думал, всё изменится,",
					"Бог с ним время наеб*ниться.",
		
					"Время умирать — и время рождаться,",
					"Время обнимать — и время уклоняться,",
					"Время бить челом — и время ерепениться",
					"И вот оно: время наеб*ниться.",
		
					"Я просил у ангела за меня вступиться,",
					"Я смотрел в небо и видел в нём лица,",
					"Я вышел к реке, высохший от жажды.",
					"И вот я стою, но не могу войти дважды.",
		
					"Лучше будет жить с бородой по пояс,",
					"Не лезть в огонь, и жить, не беспокоясь.",
					"Тело моё — клеть, душа — пленница.",
					"Хватит, поджигай, время наеб*ниться.",
				},
				{ -- My Medicine "The Pretty Reckless"
					"Somebody mixed my medicine",
					"Somebody mixed my medicine",
					
					"Well, you hurt where you sleep and you sleep where you lie",
					"And now you're in deep and now you're gonna cry",
					"Got a woman to your left and a boy to your right",
					"You start to sweat so hold me tight ('cause)",
					
					"Somebody mixed my medicine",
					"I don't know what I'm on",
					"Somebody mixed my medicine",
					"Now baby, it's all gone",
					"Somebody mixed my medicine",
					"And somebody's in my head again",
					"And somebody mixed my medicine again, again",
					
					"Well, I'll drink what you leak and I'll smoke what you sigh",
					"See across the room with a look in your eye",
					"Got a man to his left and a girl to his right",
					"I start to sweat so hold me tight",
					
					"Somebody mixed my medicine",
					"I don't know what I'm on",
					"Somebody mixed my medicine",
					"Now baby, it's all gone",
					"Somebody mixed my medicine",
					"And somebody's in my head again",
					"And somebody mixed my medicine again, again",
					
					"There's a tiger in the room and a baby in the closet",
					"Pour another drink, mom, I don't even want it",
					"Then I turn around and think I see someone that looks like you",
					
					"Well, you hurt where you sleep and you sleep where you lie",
					"And now you're in deep and now you're gonna cry",
					"Got a woman to your left and a boy to your right",
					"You start to sweat so hold me tight ('cause)",
					
					"Somebody mixed my medicine",
					"I don't know what I'm on",
					"Somebody mixed my medicine",
					"Now baby, it's all gone",
					"Somebody mixed my medicine",
					"And somebody's in my head again",
					"And somebody mixed my medicine again, again, again",
					"Again, again, again",
					"Again, again, again",
					
					"Somebody mixed my medicine",
					"Somebody mixed my medicine",
					"Somebody mixed my medicine"
				},
				{ -- Bots "Sieben Tage lang"
					"Was wollen wir trinken",
					"Sieben Tage lang -",
					"Was wollen wir trinken?",
					"So ein Durst!",
					"Was wollen wir trinken",
					"Sieben Tage lang -",
					"Was wollen wir trinken?",
					"So ein Durst!",
					"Es wird genug fur alle sein",
					"Wir trinken zusammen -",
					"Roll das Fass mal rein!",
					"Wir trinken zusammen -",
					"Nicht allein!",
					"Es wird genug fur alle sein",
					"Wir trinken zusammen -",
					"Roll das Fass mal rein!",
					"Wir trinken zusammen -",
					"Nicht allein!",
					"Dann wollen wir schaffen",
					"Sieben Tage lang!",
					"Dann wollen wir schaffen -",
					"Komm fass an!",
					"Dann wollen wir schaffen",
					"Sieben Tage lang!",
					"Dann wollen wir schaffen -",
					"Komm fass an!",
					"Und dass wird keine Plavkerei",
					"Wir schaffen zusammen",
					"Sieben Tage lang!",
					"Ja schaffen zusammen -",
					"Nicht allein!",
					"Und dass wird keine Plackerei",
					"Wir schaffen zusammen",
					"Sieben Tage lang!",
					"Ja schaffen zusammen -",
					"Nicht allein!",
					"Jetzt mussen wir streiken",
					"Keiner wei? wie lang -",
					"Ja fur ein Leben",
					"Ohne Zwang!",
					"Jetzt mussen wir streiken",
					"Keiner wei? wie lang -",
					"Ja fur ein Leben",
					"Ohne Zwang!",
					"Dann kriegt der Frust uns nicht mehr klein",
					"Wir halten zusammen -",
					"Keiner kampft allein!",
					"Wir gehen zusammen -",
					"Nicht allein!",
					"Dann kriegt der Frust uns nicht mehr klein",
					"Wir halten zusammen -",
					"Keiner kampft allein!",
					"Wir gehen zusammen -",
					"Nicht allein!",
					"La la la la la lala",
					"La la la la",
					"La lalala la la la la la",
					"La la la la la lala",
					"La la la la",
					"La lalala la la la la la",
					"La la la la la la la la",
					"La lalala la la lala",
					"La la la la",
					"La lalala la la la la la",
					"La la la la la la la la",
					"La lalala la la lala",
					"La la la la",
					"La lalala la la la la la"
				}
			}
			events:push({
				type = "start_dialogue",
				replicas = possibleReplicas[love.math.random(1, #possibleReplicas)]
			})
		end
	}
end

function obj:onEndCollide(movable)
	return {
		type = "close_info",
		text = self.infoText
	}
end

function obj:update(dt)
	self.animation:update(dt)
end

function obj:draw()
	love.graphics.polygon("line", self.body:getWorldPoints(self.shape:getPoints()))
	self.animation:draw(self.position.x, self.position.y)
end

return obj