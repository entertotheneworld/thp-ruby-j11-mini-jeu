class Game
  attr_accessor :human_player, :enemies

  def initialize(human_player, enemies = [])
    @human_player = HumanPlayer.new(human_player)
    @enemies = enemies
    for i in 1..4
      @enemies << Player.new("enemies#{i}")
    end
  end

  def kill_player(player)
    @enemies.delete_if {|element| element == player}
  end

  def is_still_ongoing?
    (@human_player.life_points > 0 && @enemies.length > 0) ? (return true) : (return false)
  end

  def show_players
    print "#{@human_player.name} Voici votre état : "
    @human_player.show_state
    puts "Etat des bots : il reste #{@enemies.length} bots"
  end

  def menu
    menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :", "\t0 - #{@enemies[0].show_state}", "\t1 - #{@enemies[1].show_state}", "\t2 - #{@enemies[2].show_state}", "\t3 - #{@enemies[3].show_state}"] if @enemies.length == 4
    menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :", "\t0 - #{@enemies[0].show_state}", "\t1 - #{@enemies[1].show_state}", "\t2 - #{@enemies[2].show_state}"] if @enemies.length == 3
    menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :", "\t0 - #{@enemies[0].show_state}", "\t1 - #{@enemies[1].show_state}"] if @enemies.length == 2
    menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :", "\t0 - #{@enemies[0].show_state}"] if @enemies.length == 1
    
    menu.each {|element| puts element}
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
      puts ""
    when "s"
      @human_player.search_health_pack
      puts ""
    when "0"
      human_player.attacks(@enemies[0])
      puts ""
      kill_player(@enemies[0]) if @enemies[0].life_points <= 0
    when "1"
      human_player.attacks(@enemies[1])
      puts ""
      kill_player(@enemies[1]) if @enemies[1].life_points <= 0
    when "2"
      human_player.attacks(@enemies[2])
      puts ""
      kill_player(@enemies[2]) if @enemies[2].life_points <= 0
    when "3"
      human_player.attacks(@enemies[3])
      puts ""
      kill_player(@enemies[3]) if @enemies[3].life_points <= 0
    end
  end

  def enemies_attack
    puts "------ Les autres joueurs t'attaquent ! ------" if @enemies.length > 0
    @enemies.each{|player| player.attacks(@human_player) if player.life_points > 0}
    puts ""
  end

  def end 
    if @human_player.life_points > 0
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
  end

end