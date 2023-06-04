#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main(int argc, char* argv[])
{
	int c;
	struct sockaddr_in server;

	c = socket(AF_INET, SOCK_DGRAM, 0);
	if(c<0)
	{	
		printf("Erraore la creearea socket client\n");
		return 1;
	}

	memset(&server, 0, sizeof(server));
	server.sin_port = htons(atoi(argv[1]));
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = inet_addr(argv[2]);

	char sir[101];
	uint16_t len;
	uint16_t port_nou;

	printf("Introdu sirul de caractere :\n");

	fgets(sir, sizeof(sir), stdin);

	len = strlen(sir);

	port_nou = 1;
	while(port_nou<40000 || port_nou>50000)
	{
		printf("Introdu noul port intre 40000 si 50000\n");
		scanf("%hu",&port_nou);
	}

	len = htons(len);

	sendto(c, &len, sizeof(len), 0, (struct sockaddr*)&server, sizeof(server));

	len = ntohs(len);

	sendto(c, sir, len, 0 , (struct sockaddr*)&server, sizeof(server));

	port_nou = htons(port_nou);

	sendto(c ,&port_nou, sizeof(port_nou), 0, (struct sockaddr*)&server, sizeof(server));
	
	server.sin_port = port_nou;

	recvfrom(c, sir, len, 0, (struct sockaddr*)&server, sizeof(server));

	printf("%s\n",sir);

	close(c);

	return 0;
}
