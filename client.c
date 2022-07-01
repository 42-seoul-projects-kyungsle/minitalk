/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/07/01 15:38:55 by kyungsle          #+#    #+#             */
/*   Updated: 2022/07/01 19:51:38 by kyungsle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	send_with_bit(int pid, char *argv)
{
	size_t	len;
	size_t	i;
	int		shift;

	len = ft_strlen(argv);
	i = 0;
	while (i < len)
	{
		shift = 0;
		while (shift < 8)
		{
			if ((argv[i] >> shift) & 1)
				kill(pid, SIGUSR2);
			else
				kill(pid, SIGUSR1);
			shift++;
			usleep(300);
		}
		i++;
	}
}

// void	client_handler(int signo, siginfo_t *info, void *context)
// {
// 	(void)context;
// 	(void)signo;
// 	if (signo == SIGUSR1 || signo == SIGUSR2)
// 	{
// 		ft_putstr_fd("Process success : ", 1);
// 		ft_putnbr_fd(info->si_signo, 1);
// 	}
// }

int	main(int argc, char **argv)
{
	pid_t	pid;

	if (argc == 3)
	{
		pid = ft_atoi(argv[1]);
		send_with_bit(pid, argv[2]);
	}
	else
		write(1, "You have to enter right arguments.\n", 2);
	while (1)
		pause();
	return (0);
}