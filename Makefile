generate-love:
	zip -r game.zip assets/ lib/ conf.lua  main.lua  src/
	mv game.zip /home/wesley/Documents/LOVE2d/love-android/app/src/main/assets/game.love
