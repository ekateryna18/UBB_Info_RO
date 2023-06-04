#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

int main(int argc, char* argv[]) {
  int c;
  struct sockaddr_in server;
  char mesaj[100];
  int numar;

  c = socket(AF_INET, SOCK_DGRAM, 0);
  if (c < 0) {
    printf("Eroare la crearea socketului client\n");
    return 1;
  }

  memset(&server, 0, sizeof(server));
  server.sin_port = htons(atoi(argv[1]));
  server.sin_family = AF_INET;
  server.sin_addr.s_addr = inet_addr(argv[2]);
  
  sendto(c, argv[2], 100, 0, (struct sockaddr *) &server, sizeof(server));
  
  printf("introduceti un sir: ");
  gets(mesaj);

  sendto(c, mesaj, sizeof(mesaj), 0, (struct sockaddr *) &server, sizeof(server));

  int default_port;
  int l = sizeof(server);
  recvfrom(c, &default_port, sizeof(default_port), 0, (struct sockaddr *) &server, &l);
  printf("am primit noul port %d de la server.\n", default_port);

  server.sin_port = htons(default_port);

  char last_ip[100];
  recvfrom(c, last_ip, sizeof(last_ip), 0, (struct sockaddr *) &server, &l);
  printf("am primit ip ul anterior %s de la server\n", last_ip);
  
  close(c);
}


