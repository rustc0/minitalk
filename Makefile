CC = cc -Wall -Wextra -Werror

CLIENT_SRC = client.c
SERVER_SRC = server.c
CLIENT_OBJ = $(CLIENT_SRC:.c=.o)
SERVER_OBJ = $(SERVER_SRC:.c=.o)
HEADER_FILE = minitalk.h

CLIENT = client
SERVER = server

#------------------| RULES |-------------------#

all: $(CLIENT) $(SERVER)

$(CLIENT): $(CLIENT_OBJ) $(HEADER_FILE)
	$(CC) $< -o $@

$(SERVER): $(SERVER_OBJ) $(HEADER_FILE)
	$(CC) $< -o $@

%.o: %.c
	$(CC) -c $< -o $@

clean:
	rm -f $(CLIENT_OBJ) $(SERVER_OBJ)

fclean: clean
	rm -f $(CLIENT) $(SERVER)

re: fclean all

.PHONY: all clean fclean re
