/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/07/01 15:38:55 by kyungsle          #+#    #+#             */
/*   Updated: 2022/07/04 14:31:54 by kyungsle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	exit_print_error(int i)
{
	if (i == 0)
		ft_putstr_fd("Error sending message to server.\n", 1);
	if (i == 1)
		ft_putstr_fd("Error getting message from server.\n", 1);
	if (i == 2)
		ft_putstr_fd("You have to enter right arguments.\n", 1);
	exit(1);
}

void	send_with_bit(int pid, char *argv)
{
	size_t	len;
	size_t	i;
	int		move;

	len = ft_strlen(argv);
	i = 0;
	while (i <= len)
	{
		move = 0;
		while (move < 8)
		{
			if ((argv[i] >> move) & 1)
			{
				if (kill(pid, SIGUSR2) == -1)
					exit_print_error(0);
			}
			else
				if (kill(pid, SIGUSR1) == -1)
					exit_print_error(0);
			move++;
			usleep(1000);
		}
		i++;
	}
}

void	client_handler(int signo, siginfo_t *info, void *context)
{
	(void)context;
	if (signo == SIGUSR2)
	{
		ft_putstr_fd("Talk success with ", 1);
		ft_putnbr_fd(info->si_pid, 1);
		write(1, "\n", 1);
		exit(0);
	}
}

int	main(int argc, char **argv)
{
	struct sigaction	sa;

	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = client_handler;
	if (sigaction(SIGUSR1, &sa, NULL) == -1
		|| sigaction(SIGUSR2, &sa, NULL) == -1)
		exit_print_error(1);
	if (argc == 3)
		send_with_bit(ft_atoi(argv[1]), argv[2]);
	else
		exit_print_error(2);
	while (1)
		pause();
	return (0);
}
