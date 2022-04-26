class Game
  attr_accessor :human_player, :enemies_in_sight, :players_left
  @@counter_enemies_remove = 0
  @@counter_enemies_in_view = 0


  def initialize(human_player, enemies_in_sight = [], players_left = 10)
    @human_player = HumanPlayer.new(human_player)
    @players_left = players_left
    @enemies_in_sight = enemies_in_sight
  end

  def new_players_in_sight
    dice = rand(1..6)
    if @@counter_enemies_in_view == @players_left
      puts "Tous les joueurs sont déjà en vue"
    elsif dice == 1
      puts "Pas de nouveaux bots n'arrive"
    elsif dice >= 2 && dice <= 4
      @@counter_enemies_in_view += 1
      @enemies_in_sight << Player.new("enemies_#{rand(1000..9999)}")
      puts "Un nouveau bot arrive"
    else 
      @@counter_enemies_in_view += 2
      if @@counter_enemies_in_view <= 10
        for i in 1..2
          @enemies_in_sight << Player.new("enemies_#{rand(1000..9999)}")
        end
        puts "2 nouveaux bots arrivent"
      elsif @@counter_enemies_in_view > 10
        @enemies_in_sight << Player.new("enemies_#{rand(1000..9999)}")
        puts "Un nouveau bot arrive"
      end
    end
  end

  def kill_player(player)
    @enemies_in_sight.delete_if {|element| element == player}
    @@counter_enemies_remove += 1
  end

  def is_still_ongoing?
    (@human_player.life_points > 0 && @@counter_enemies_remove < @players_left) ? (return true) : (return false)
  end

  def show_players
    print "#{@human_player.name} Voici votre état : "
    @human_player.show_state
    puts "Etat des bots : il y a #{@enemies_in_sight.length} bots en vue et il reste #{@players_left - @enemies_in_sight.length - @@counter_enemies_remove} bots à arriver."
  end

  def menu
    menu = ["\n", "Quelle action veux-tu effectuer ?", "\ta - chercher une meilleure arme", "\ts - chercher à se soigner ", "\n", "attaquer un joueur en vue :"]
    @enemies_in_sight.each_with_index {|player, i| menu << "\t#{i} - #{player.show_state}"}
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
    when "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"
      choice = choice.to_i
      human_player.attacks(@enemies_in_sight[choice])
      puts ""
      kill_player(@enemies_in_sight[choice]) if @enemies_in_sight[choice].life_points <= 0
    end
  end

  def enemies_attack
    puts "------ Les autres joueurs t'attaquent ! ------" if @enemies_in_sight.length > 0
    @enemies_in_sight.each{|player| player.attacks(@human_player) if player.life_points > 0}
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