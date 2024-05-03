^~
'''
body {
  text-align: center;
  width: 100vw;
  height: 100vh;
  margin: 0;
  background: repeating-linear-gradient(
    45deg,
    #D8CDCD,
    #D8CDCD 10px,
    #999392 10px,
    #999392 20px
  );
  animation: drift 2s infinite alternate ease-in-out;
}

@keyframes drift {
  0%, 100% {
    background-position: 0 0;
  }
  25% {
    background-position: 1000px -1000px;
  }
  50% {
    background-position: 200px 0;
  }
  75% {
    background-position: -100px 100px;
  }
}
'''
