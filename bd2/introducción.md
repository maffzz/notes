
- optimizar el acceso a memoria secundaria
- memoria secundaria -> + lenta pero persistente
- memoria RAM -> + rápida pero no es persistente
- bases de datos distribuidos

- pull de conexiones -> cantidad máxima de conexiones activas a la base de datos o a sus recursos -> a lo mucho admite 100 ejemplo, conexiones concurrentes, si sobrepasa se va a la cola de prioridad) -> cuando llega al limite se crea otro servidor de postgres

- concurrencia -> 2 procesos acceden al mismo recurso (resuelto con transacciones)
- paralelismo -> 2 procesos se ejecutan al mismo tiempo

- eficiencia -> uso de recursos de forma optima -> optimizar el transporte de paquetes por la red

- más servidores para responder a todas las conexiones -> crecimiento horizontal del hardware para suplir la demanda (escalabilidad)

- optimización sintáctica : reescribir query para que sea mas eficiente
- optimización física : índices (joins, consulta recurrente)

- diseño físico del gestor de base de datos
- bases de datos espaciales y vectoriales

---

next: [[sistemas de gestión de bases de datos]]
tags: [[bd]]