# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/01 15:19:20 by kyungsle          #+#    #+#              #
#    Updated: 2022/07/01 15:30:22 by kyungsle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		= cc
RM		= rm -f
CFLAGS	= -Wall -Wextra -Werror
CLIENT = client
SERVER = server
CLIENTB = client_bonus
SERVERB = server_bonus
NAME	= $(CLIENT) $(SERVER)
BONUS	= $(CLIENTB) $(SERVERB)
SRCS	= ./mandatory/so_long.c \
		  ./mandatory/image.c \
SRCSB	= ./bonus/so_long_bonus.c \
		  ./bonus/image_bonus.c \
		  ./bonus/ft_itoa.c
OBJS	= $(SRCS:.c=.o)
OBJSB	= $(SRCSB:.c=.o)
MLX_DIR	= ./mlx/

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

$(NAME): $(OBJS)
	make -C $(MLX_DIR)
	$(CC) -o $(NAME) $(OBJS) -L./mlx -lmlx -framework OpenGL -framework AppKit

$(BONUS): $(OBJSB)
	make -C $(MLX_DIR)
	$(CC) -o $(BONUS) $(OBJSB) -L./mlx -lmlx -framework OpenGL -framework AppKit

all: $(NAME)

bonus: $(BONUS)

clean:
	make -C $(MLX_DIR) clean
	$(RM) $(OBJS) $(OBJSB)

fclean: clean
	$(RM) $(NAME) $(BONUS)

re: 
	make fclean
	make all

.PHONY: all clean fclean re bonus
