require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'


####### INITIALISATION DU JEUX
puts "-------------------------------------------------"
puts "|   Bienvenue sur 'ILS VEULENT TOUS MA POO' !   |"
puts "|Le but du jeu est d'être le dernier survivant !|"
puts "-------------------------------------------------"


####### INITIALISATION DES JOUEURS
puts "Entrez votre prénom :"
name_human_player = gets.chomp
my_game = Game.new(name_human_player)


####### LE COMBAT
while my_game.is_still_ongoing?

  # AFFICHER ETAT DU JOUEUR
  my_game.show_players

  # CHOIX DU JOUEUR
  my_game.menu
  tab_choice = ["a","s","0","1","2","3"]
  tab_choice = ["a","s","0","1","2"] if my_game.enemies.length == 3
  tab_choice = ["a","s","0","1"] if my_game.enemies.length == 2
  tab_choice = ["a","s","0"] if my_game.enemies.length == 1
  choice = gets.chomp
  puts ""
  until tab_choice.include?(choice)
    puts "ERROR, Veuillez réessayer"
    choice = gets.chomp
    puts ""
  end

  # ACTION DU JOUEUR
  my_game.menu_choice(choice)

  # ATTAQUE BOTS
  my_game.enemies_attack

end


####### FIN DU JEUX
my_game.end