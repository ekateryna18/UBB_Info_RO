/*Un client trimite unui server un sir de caractere si doua numere(fie acestea s, i, l).
Serverul va returna clientului subsirul de lungime l a lui s care incepe la pozitia i.*/
//ex: s= 0123456 i=2 l=3 rez = 234
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>
 
int main() {
  int c;
  struct sockaddr_in server;
  char buffer[1024];
  uint16_t a, b, suma;
  char sir[100], sir2[100];
  
  c = socket(AF_INET, SOCK_STREAM, 0);
  if (c < 0) {
    printf("Eroare la crearea socketului client\n");
    return 1;
  }
  
  memset(&server, 0, sizeof(server));
  server.sin_port = htons(1234);
  server.sin_family = AF_INET;
  server.sin_addr.s_addr = inet_addr("127.0.0.1");
  
  if (connect(c, (struct sockaddr *) &server, sizeof(server)) < 0) {
    printf("Eroare la conectarea la server\n");
    return 1;
  }
  //a = lungimea
  //b = poz
  printf("string: ");
  fgets(sir, 100, stdin);
  printf("a = ");
  scanf("%hu", &a);
  printf("b = ");
  scanf("%hu", &b);
  a = htons(a);
  b = htons(b);
  send(c, sir, sizeof(sir), 0);
  send(c, &a, sizeof(a), 0);
  send(c, &b, sizeof(b), 0);

  int len;
  recv(c, &len, sizeof(len), MSG_WAITALL);
  len = ntohl(len);
  printf("%d\n", len);
  recv(c, sir2, len, MSG_WAITALL);
  sir2[len] = '\0';
 /* recv(c, &suma, sizeof(suma), 0);
  suma = ntohs(suma);
  printf("Suma este %hu\n", suma);*/
  printf("Sir primit: %s", sir2);
  close(c);
}