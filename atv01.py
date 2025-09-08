import threading
import time

def imprime_1_a_10():
    for i in range(1, 11):
        print(f"Thread-1: {i}")
        time.sleep(0.5)  # simula tempo de processamento

def imprime_50_a_60():
    for i in range(50, 61):
        print(f"Thread-2: {i}")
        time.sleep(0.5)  # simula tempo de processamento

#Criando as threads
t1 = threading.Thread(target=imprime_1_a_10)
t2 = threading.Thread(target=imprime_50_a_60)

#Início das threads
t1.start()
t2.start()

#Esperando as duas finalizarem antes de encerrar o programa
t1.join()
t2.join()

print #Fim