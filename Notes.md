# Восстновление пароля

+ Если пользователь не восстановил пароль по токену, и
пытается еще раз восстановить пароль, то:
1. Запись со старым токеном удаляется (по **user_id**)
2. Запись с новым токеном для восстановления пароля создается

+ При восстановлении пароля следует так же обновить инфу о подтверждении
почты, если она не была подтверждена до этого.