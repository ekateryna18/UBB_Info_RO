#include <stdio.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main(int argc, char* argv[])
{

	int s;

	struct sockaddr_in server,client;
	int c,l;

	s = socket(AF_INET, SOCK_DGRAM, 0);
	if(s<0)
	{
		printf("Erraore la creearea socket server \n");
		return 1;
	}

	memset(&server, 0, sizeof(server));

	server.sin_port = htons(atoi(argv[1]));
	server.sin_family = AF_INET;
	server.sin_addr.s_addr = INADDR_ANY;

	if( bind(s, (struct sockaddr *) &server, sizeof(server))<0)
	{
		printf("Erroare la bine \n");
		return 1;
	}

	l = sizeof(client);
	memset(&client,0,l);

	char sir[101];
	uint16_t port_nou;
	uint16_t len;

	recvfrom(s, &len, sizeof(len), 0, (struct sockaddr*) &client, &l);
	len = ntohs(len);
	recvfrom(s, sir, len, 0, (struct sockaddr*)&client, &l);

	recvfrom(s, &port_nou, sizeof(port_nou), 0, (struct sockaddr*) &client, &l);

	port_nou = ntohs(port_nou);

	printf("%s\n %hu\n",sir,port_nou);

	close(s);

	 memset(&server, 0, sizeof(server));

        server.sin_port = htons(port_nou);
        server.sin_family = AF_INET;
        server.sin_addr.s_addr = INADDR_ANY;


	  s = socket(AF_INET, SOCK_DGRAM, 0);
        if(s<0)
        {
                printf("Erraore la creearea socket server \n");
                return 1;
        }



	 if( bind(s, (struct sockaddr *) &server, sizeof(server))<0)
        {
                printf("Erroare la bind \n");
                return 1;
        }


	int i;
	for(i=0;i<strlen(sir);i++)
	{
		sir[i] = 'Z'-(sir[i]-'A');
	
	}
	
	sendto(s, sir, len, 0, (struct sockaddr*)&client, sizeof(client));

	printf("Gata executie\n");

	return 0;
}
