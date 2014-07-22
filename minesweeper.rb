require 'colorize'

class Board
	attr_accessor :row, :col, :cells_list
	def initialize row, col
		@row = row
		@col = col
	end
	def generate_random_cells
		random_cells = []
		(self.row*self.col).times do
			random_cells << Cell.new
		end
		random_cells.sample(self.row).each do |cell|
			cell.has_mine = true
		end
		self.cells_list = random_cells		
	end
	def generate		
		self.row.times { print " - " }
		i = 0
		self.cells_list.each do |cell|
			puts " " if i%self.row == 0
			print cell.show
			i+=1;
		end
		puts " "
		self.row.times { print " - " }
		puts " "
	end
	def open x,y
		cell_to_open  = self.cells_list[ (self.row * x)+y ]
		if cell_to_open.has_mine
			self.open_all_mines
			return true
		else
			cell_to_open.open
			return false
		end
	end
	def open_all_mines
		self.cells_list.each do |cell|
			cell.mine_opened = true if cell.has_mine
		end
	end
end

class Cell 
	attr_accessor :closed, :has_mine, :mine_opened
	def show
		return " @ ".colorize(:background => :red) if self.mine_opened
		self.closed ? " X ":" O "
	end
	def initialize 
		@closed = true
		@has_mine = false
		@mine_opened = false
	end
	def open
		self.closed = false
	end		
end

class MineSweeper
	attr_accessor :board
	def init
		puts "Enter the number of rows and columns of board";
		self.board = Board.new(gets.chomp.to_i, gets.chomp.to_i); 
		self.board.generate_random_cells
		self.board.generate
	end
	def start
		puts "Cell to open x,y: (q to quit) "
		user_input = gets.chomp
		while(user_input != 'q')
			x,y = user_input.split(',')
			game_end = self.board.open(x.to_i,y.to_i)
			if game_end
				board.generate
				break;
			else
				self.board.generate
				user_input = gets.chomp
			end
		end
		puts "Game Over!!! Thanks for playing..."
	end
end

game = MineSweeper.new
game.init;
game.start






