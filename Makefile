# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2022/07/01 15:19:20 by kyungsle          #+#    #+#              #
#    Updated: 2022/07/01 19:19:00 by kyungsle         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

.DEFAULT_GOAL = all

SRCS_FILES = server.c client.c

SRCS_OBJS = $(SRCS_FILES:.c=.o)

BONUS_FILES = server_bonus.c client_bonus.c

BONUS_OBJS = ${BONUS_FILES:.c=.o}

CC	= cc

RM	= rm -f

CFLAGS	= -Wall -Wextra -Werror

LIB	= libft

NAME = ${SERVER} ${CLIENT}

SERVER = server

CLIENT = client

NAME_B = ${SERVER_B} ${CLIENT_B}

SERVER_B = server_b

CLIENT_B = client_b

${SERVER}: server.o ./libft/libft.a
	gcc ${CFLAGS} -o ${SERVER}  server.o -L${LIB} -lft

${CLIENT}: client.o ./libft/libft.a
	gcc ${CFLAGS} -o ${CLIENT}  client.o -L${LIB} -lft

${SERVER_B}: server_bonus.o ./libft/libft.a
	gcc ${CFLAGS} -o ${SERVER}  server_bonus.o -L${LIB} -lft

${CLIENT_B}: client_bonus.o ./libft/libft.a
	gcc ${CFLAGS} -o ${CLIENT}  client_bonus.o -L${LIB} -lft
	
all: ${NAME}

%.o: %.c
	${CC} -c ${CFLAGS} $?

./libft/libft.a:
	make -C libft/
	
clean:
	${RM} $(SRCS_OBJS) ${BONUS_OBJS}
	make -C libft clean

fclean: clean
	${RM} ${NAME} ${NAME_B} ${LIB}/libft.a

bonus: ${NAME_B}

re: fclean all

.PHONY: all libft clean fclean re bonus
