/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   server.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: kyungsle <kyungsle@student.42.kr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2022/07/01 15:38:57 by kyungsle          #+#    #+#             */
/*   Updated: 2022/07/01 22:43:26 by kyungsle         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

void	exit_print_error(int i)
{
	if (i == 0)
		ft_putstr_fd("Error sending message to client.\n", 1);
	if (i == 1)
		ft_putstr_fd("Error getting message from client.\n", 1);
	exit(1);
}

void	get_with_bit(int sig)
{
	g_signal.size++;
	g_signal.msg = g_signal.msg >> 1;
	if (sig == SIGUSR2)
		g_signal.msg = g_signal.msg | 128;
	if (g_signal.size == 8)
	{
		write(1, &(g_signal.msg), 1);
		g_signal.size = 0;
		if (g_signal.msg == 0)
			if (kill(g_signal.pid, SIGUSR2) == -1)
				exit_print_error(0);
	}
}

void	server_handler(int signo, siginfo_t *info, void *context)
{
	(void) context;
	g_signal.pid = info->si_pid;
	get_with_bit(signo);
}

int	main(void)
{
	pid_t				pid;
	struct sigaction	sa;

	g_signal.size = 0;
	g_signal.msg = 0;
	sa.sa_flags = SA_SIGINFO;
	sa.sa_sigaction = server_handler;
	if (sigaction(SIGUSR1, &sa, NULL) == -1 ||
		sigaction(SIGUSR2, &sa, NULL) == -1)
		exit_print_error(1);
	pid = getpid();
	ft_putstr_fd("Process ID is ", 1);
	ft_putnbr_fd(pid, 1);
	write(1, "\n", 1);
	while (1)
		pause();
	return (0);
}