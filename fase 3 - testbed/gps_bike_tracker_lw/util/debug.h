#ifndef DEBUG_H
#define DEBUG_H

#ifdef DEBUG
#define LOG(origin,msg)    Serial.printf("%s(): %s\n", origin, msg)
#else
#define LOG(origin,msg)
#endif /* DEBUG */

#ifdef DEBUG
extern  int     debug;
#endif

#endif	/* DEBUG_H */