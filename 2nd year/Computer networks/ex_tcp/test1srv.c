#include<stdio.h>   //printf    
#include<string.h>  //strlen
#include<sys/socket.h>  //socket
#include<arpa/inet.h>   //inet_addr
#include<unistd.h>      //write

#include<stdlib.h>

#include <sys/types.h>  //recvfrom
#include <sys/socket.h> //recvfrom

#define DEFAULT_BUFLEN      512
#define DEFAULT_CLIENT_PORT     27016
#define DEFAULT_SERVER_PORT     27015
#define NUM_OF_PAR      7

int main(int argc , char *argv[])
{
    int socket_desc, client_sock, c, read_size;
    struct sockaddr_in server, client;
    char client_message[DEFAULT_BUFLEN];
    int sock;

    //Create socket
    socket_desc = socket(AF_INET, SOCK_STREAM, 0);
    if (socket_desc == -1)
    {
            printf("Could not create socket");
        }
        puts("Socket created");

    //Prepare the sockaddr_in structure
    server.sin_family = AF_INET;
    server.sin_addr.s_addr = inet_addr("127.0.0.1");
        server.sin_port = htons(8888);

        //Bind
        if(bind(socket_desc, (struct sockaddr *)&server, 
sizeof(server)) < 0)
        {
            //print the error message
            perror("bind failed. Error");
            return 1;
        }
        puts("bind done");

        //Listen
        listen(socket_desc, 1);

        //Accept and incoming connection
        puts("Waiting for incoming connections...");
        c = sizeof(struct sockaddr_in);

        //accept connection from an incoming client
        client_sock = accept(socket_desc, (struct sockaddr *)&client, 
(socklen_t*)&c);
        if(client_sock < 0)
        {
            perror("accept failed");
            return 1;
        }
        puts("Connection accepted");


        //Receive a message from client
    int arrayReceived[NUM_OF_PAR];

    while((read_size = recv(client_sock, &arrayReceived, NUM_OF_PAR, 
0)) > 0){
        printf("Received well\n");  
    }

    if(read_size == 0)
        {
            puts("Client disconnected");
        }
        else if(read_size == -1)
        {
            perror("recv failed");
        }

    printf("Received parameters:    \n");
    for(int i = 0; i < NUM_OF_PAR; i++)
    {
        printf("%d  ", arrayReceived[i]);
    }

    printf("\n");

        close(sock);

        return 0;
}



