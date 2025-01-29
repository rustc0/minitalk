/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: rahmoham <rahmoham@student.42.fr>          #+#  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2025-01-10 21:59:41 by rahmoham          #+#    #+#             */
/*   Updated: 2025-01-10 21:59:41 by rahmoham         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "minitalk.h"

int	ft_atoi(const char *str)
{
	int	i;
	int	n;
	int	res;

	i = 0;
	n = 1;
	res = 0;
	while ((str[i] >= 9 && str[i] <= 13)
		|| str[i] == 32 || str[i] == '+')
		i++;
	if (!(str[i] >= '0' && str[i] <= '9'))
		return (0);
	while (str[i] >= '0' && str[i] <= '9')
	{
		res = res * 10 + (str[i] - '0');
		i++;
	}
	if (str[i] && !(str[i] >= '0' && str[i] <= '9'))
		return (0);
	return (res * n);
}

int	send_signal(int pid, int sig)
{
	static int	err_found;

	if (!err_found)
	{
		if (kill (pid, sig) == -1)
		{
			err_found = 1;
			perror("signal could not sent");
			return (-1);
		}
	}
	return (0);
}

void	send_char(int pid, char c)
{
	int	bit;

	bit = 0;
	while (bit < 8)
	{
		if (c & 1)
			send_signal(pid, SIGUSR1);
		else
			send_signal(pid, SIGUSR2);
		c >>= 1;
		usleep(100);
		bit++;
	}
}

int	main(int ac, char *av[])
{
	int	pid;
	int	i;

	i = 0;
	if (ac == 3)
	{
		pid = ft_atoi(av[1]);
		if (pid == 0)
		{
			write(2, "invalid pid\n", 13);
			return (-1);
		}
		while (av[2][i])
		{
			send_char(pid, av[2][i]);
			i++;
		}
		send_char(pid, '\n');
	}
	else
	{
		write(1, "Error : wrong format\n", 21);
		return (1);
	}
}
