#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <netinet/in.h>
#include <netinet/ip.h>
#include <string.h>

char last_ip[100];


int numar_spatii(char mesaj[100]){
  int nr_spatii = 0;
  for (int i=0; i<strlen(mesaj); i++)
	if (mesaj[i] == ' ')
	    nr_spatii++;
  return nr_spatii;
}

char* caractere_distincte(char mesaj[100]){
  int frecv[200];
  char caract_dist[100];

  memset(caract_dist, 0, sizeof(caract_dist));
  memset(&frecv, 0, sizeof(frecv));

  for (int i=0;i<strlen(mesaj);i++){
  	frecv[mesaj[i]]++;
  }
  
  int poz = 0;
  for (int i=0; i<200; i++)
	if (frecv[i] != 0)
	  caract_dist[poz++] = i;

  caract_dist[poz] = '\0';
  return caract_dist;
}

//void deservire_client(struct sockaddr_in client, int s){
//  int l = sizeof(client);
//  char ip[100];
//  char mesaj[100];
//  int numar;
//  
//  memset(&ip, 0, sizeof(ip));
//  recvfrom(s, ip, sizeof(ip), 0, (struct sockaddr *) &client, &l);
//  printf("s a conectat clientul cu ip-ul: %s\n", ip);
//  printf("clientul anterior a avut ip-ul: %s\n\n", last_ip);
//
//  recvfrom(s, mesaj, sizeof(mesaj), 0, (struct sockaddr *) &client, &l);
//  printf("am primit mesajul %s\n", mesaj);
//  
//  int nr_spatii = numar_spatii(mesaj);
//  printf("numarul de spatii este: %d\n", nr_spatii);
//
//  int default_port = 1000 + nr_spatii;
//  printf("noul port este: %d. Se trimite clientului...\n\n", default_port);
//  sendto(s, &default_port, sizeof(default_port), 0, (struct sockaddr *) &client, sizeof(client));
//
//  sendto(s, last_ip, sizeof(last_ip), 0, (struct sockaddr *) &client, sizeof(client));
//  strcpy(last_ip, ip);
//
//}

int main(int argc, char* argv[]) {
  int s;
  struct sockaddr_in server, client;
  int l, port_nr=atoi(argv[1]);

  s = socket(AF_INET, SOCK_DGRAM, 0);
  if (s < 0) {
    printf("Eroare la crearea socketului server\n");
    return 1;
  }

  memset(&server, 0, sizeof(server));
  server.sin_port = htons(atoi(argv[1]));
  server.sin_family = AF_INET;
  server.sin_addr.s_addr = INADDR_ANY;

  if (bind(s, (struct sockaddr *) &server, sizeof(server)) < 0) {
    printf("Eroare la bind\n");
    return 1;
  }

  l = sizeof(client);
  memset(&client, 0, sizeof(client));

  char ip[100];
  char mesaj[100];
  int numar;

  while (1) {

      memset(&ip, 0, sizeof(ip));
      recvfrom(s, ip, sizeof(ip), 0, (struct sockaddr*)&client, &l);
      printf("s a conectat clientul cu ip-ul: %s\n", ip);
      printf("clientul anterior a avut ip-ul: %s\n\n", last_ip);

      recvfrom(s, mesaj, sizeof(mesaj), 0, (struct sockaddr*)&client, &l);
      printf("am primit mesajul %s\n", mesaj);

      int nr_spatii = numar_spatii(mesaj);
      printf("numarul de spatii este: %d\n", nr_spatii);

      int default_port = port_nr + nr_spatii;
      port_nr = default_port;
      printf("noul port este: %d. Se trimite clientului...\n\n", default_port);
      sendto(s, &default_port, sizeof(default_port), 0, (struct sockaddr*)&client, sizeof(client));

      close(s);

      s = socket(AF_INET, SOCK_DGRAM, 0);
      if (s < 0) {
          printf("Eroare la crearea socketului server\n");
          return 1;
      }

      memset(&server, 0, sizeof(server));
      server.sin_port = htons(default_port);
      server.sin_family = AF_INET;
      server.sin_addr.s_addr = INADDR_ANY;

      if (bind(s, (struct sockaddr*)&server, sizeof(server)) < 0) {
          printf("Eroare la bind\n");
          return 1;
      }

      sendto(s, last_ip, sizeof(last_ip), 0, (struct sockaddr*)&client, sizeof(client));
      strcpy(last_ip, ip);

  }

  close(s);
}



