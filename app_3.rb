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

  # INTEGRATION NOUVEAUX BOTS
  my_game.new_players_in_sight

  # CHOIX DU JOUEUR
  my_game.menu
  tab_choice = ["a","s"]
  my_game.enemies_in_sight.each_with_index {|player,i| tab_choice << "#{i}"}
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