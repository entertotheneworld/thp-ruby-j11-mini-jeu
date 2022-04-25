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
human_player = HumanPlayer.new(name_human_player)
player1 = Player.new("Josiane")
player2 = Player.new("José")
fighters = [player1, player2]


####### LE COMBAT
while human_player.life_points >0 && (player1.life_points > 0 || player2.life_points >0)

  # AFFICHER ETAT DU JOUEUR
  print "Voici votre état : "
  human_player.show_state

  # CHOIX DU JOUEUR
  menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :", "\t0 - #{player1.show_state}", "\t1 - #{player2.show_state}"]
  menu.each {|element| puts element}
  tab_choice = ["a","s","0","1"]
  choice = gets.chomp
  puts ""
  until tab_choice.include?(choice)
    puts "ERROR, Veuillez entrez : a, s, 0 ou 1"
    choice = gets.chomp
    puts ""
  end

  # ACTION DU JOUEUR
  case choice
  when "a"
    human_player.search_weapon
    puts ""
  when "s"
    human_player.search_health_pack
    puts ""
  when "0"
    human_player.attacks(player1)
    puts ""
  when "1"
    human_player.attacks(player2)
    puts ""
  end

  # ATTAQUE BOTS
  puts "------ Les autres joueurs t'attaquent ! ------" if player1.life_points > 0 || player2.life_points > 0
  fighters.each{|player| player.attacks(human_player) if player.life_points > 0}
  puts ""
end


####### FIN DU JEUX
if human_player.life_points > 0
  puts "-------------------------------------------------"
  puts "|               Fin de la partie !              |"
  puts "|        BRAVO ILS N'ONT PAS EU TA POO !        |"
  puts "-------------------------------------------------"
else 
  puts "-------------------------------------------------"
  puts "|               Fin de la partie !              |"
  puts "|            LOSER ILS ONT EU TA POO!           |"
  puts "-------------------------------------------------"
end