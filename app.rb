require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# INITIALISATION DES JOUEURS
player1 = Player.new("Josiane")
player2 = Player.new("José")

# LE COMBAT
while player1.life_points > 0 && player2.life_points >0
  puts "Voici l'état de chaque joueur :"
  print "\t* "
  puts player1.show_state
  print "\t* "
  puts player2.show_state
  puts ""
  puts "Passons à la phase d'attaque :"
  player1.attacks(player2)
  break if player2.life_points <= 0
  player2.attacks(player1)
  puts ""
end