# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/01 15:19:20 by kyungsle          #+#    #+#              #
#    Updated: 2022/07/01 23:40:32 by kyungsle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

CC		= cc
RM		= rm -f
CFLAGS	= -Wall -Wextra -Werror
CLIENT	= client
SERVER	= server
NAME	= $(CLIENT) $(SERVER)
CLIENTB	= client_bonus
SERVERB	= server_bonus
BONUS	= $(CLIENTB) $(SERVERB)
SRCS	= ./mandatory/client.c
SRCS2	= ./mandatory/server.c
SRCSB	= ./bonus/client_bonus.C
SRCSB2	= ./bonus/server_bonus.c
OBJS	= $(SRCS:.c=.o)
OBJS2	= $(SRCS2:.c=.o)
OBJSB	= $(SRCSB:.c=.o)
OBJSB2	= $(SRCSB2:.c=.o)
LIB_DIR	= ./libft/
LIB	= libft

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $(<:.c=.o)

$(NAME): $(OBJS) $(OBJS2)
	make -C $(LIB_DIR)
	$(CC) -o $(CLIENT) $(OBJS) -L${LIB} -lft
	$(CC) -o $(SERVER) $(OBJS2) -L${LIB} -lft

$(BONUS): $(OBJSB) $(OBJSB2)
	make -C $(LIB_DIR)
	$(CC) -o $(CLIENTB) $(OBJSB) -L${LIB} -lft
	$(CC) -o $(SERVERB) $(OBJSB2) -L${LIB} -lft

all: $(NAME)

bonus: $(BONUS)

clean:
	make -C $(LIB_DIR) clean
	$(RM) $(OBJS) $(OBJS2) $(OBJSB) $(OBJSB2)

fclean: clean
	make -C $(LIB_DIR) fclean
	$(RM) $(CLIENT) $(SERVER) $(CLIENTB) $(SERVERB)

re: 
	make fclean
	make all

.PHONY: all clean fclean re bonus
