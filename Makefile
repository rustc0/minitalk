CC = cc -Wall -Wextra -Werror

CLIENT_SRC = client.c
SERVER_SRC = server.c
CLIENT_BONUS_SRC = client_bonus.c
SERVER_BONUS_SRC = server_bonus.c
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)
SERVER_OBJ = $(SERVER_SRC:.c=.o)
CLIENT_BONUS_OBJ = $(CLIENT_BONUS_SRC:.c=.o)
SERVER_BONUS_OBJ = $(SERVER_BONUS_SRC:.c=.o)
HEADER_FILE = minitalk.h

CLIENT = client
SERVER = server

BONUS_CLIENT = bonus_client
BONUS_SERVER = bonus_server

#------------------| RULES |-------------------#

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJ) $(HEADER_FILE)
	$(CC) $< -o $@

$(SERVER): $(SERVER_OBJ) $(HEADER_FILE)
	$(CC) $< -o $@

$(BONUS_CLIENT): $(CLIENT_BONUS_OBJ)
	$(CC) $< -o $@

$(BONUS_SERVER): $(SERVER_BONUS_OBJ)
	$(CC) $< -o $@

%.o: %.c
	$(CC) -c $< -o $@

bonus: $(BONUS_CLIENT) $(BONUS_SERVER)

clean:
	rm -f $(CLIENT_OBJ) $(SERVER_OBJ) $(CLIENT_BONUS_OBJ) $(SERVER_BONUS_OBJ)

fclean: clean
	rm -f $(CLIENT) $(SERVER) $(BONUS_CLIENT) $(BONUS_SERVER)

re: fclean all

.PHONY: all clean fclean re
