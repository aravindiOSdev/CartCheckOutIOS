# CartCheckOutIOS

El objetivo del proyecto es desarrollar parte de una aplicación de iOS que servirá para queusuarios realicen pedidos a supermercados.
Las funcionalidades que comprende el proyecto se comprenden en dos pantallas que sedescriben en las siguientes páginas, también se proveen imagen mostrando el diseño de UIbuscado, la aplicación deberá verse exactamente como dichas imágenes.

Junto con la letra se proveen algunas imágenes necesarias para construir la UI y otrasusadas en los productos que se ven en el diseño, estas últimas son a modo de ejemplo y seespera que se amplíe ese listado de productos en el juego de datos que el estudiantedefina.El juego de datos se construirá localmente, esta versión de la aplicación no contara conningún tipo de coneccion con un servidor. Se espera que esta lógica de construcción dedatos esté encapsulada en la capa de modelo, como corresponde.El segundo obligatorio podría o no usar a este como punto de partida. Ampliando lasfuncionalidades y agregando características.
Pantalla principalContiene:

●Un carrito en la parte superiorderecha que permitirá navegar a lapantalla de checkout.

●Un banner con propagandas sobreartículos destacados.

●Un search que permitirá filtrar ellistado de artículos por nombres y categorías.

●Un listado de artículos.


Por defecto todas las celdas del listadotendrán el botón de "Add" visible. Si hay unao más unidades seleccionadas del mismoartículo, se ocultará el botón y se regulará lacantidad de unidades con los botones de "+"y "-".
Pantalla de checkoutEn ella se podrán visualizar los elementosque se encuentran en el carrito decompras antes de confirmarlo. Si no hayelementos en el carrito el botón decheckout debe estar deshabilitado.Es importante que independientementedel dispositivo donde se corra laaplicación siempre debe haber dos itemsfor fila.Si el usuario toca un item se debedesplegar un picker donde puedemodificar la cantidad de unidades.Una vez que el usuario presiona"Checkout" deberá desplegarse un alertque le indique al usuario que la comprafue realizada exitosamente, navegar a lapantalla principal y vaciar el carrito decompras.
Criterio de evaluación.El proyecto debe correr en cualquier dispositivo con iOS 10.0 en adelante y no es necesariosoportar modo landscape (rotar la pantalla).
