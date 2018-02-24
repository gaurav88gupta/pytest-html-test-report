class Sample:
    x =0
    def inc(self,x):
        x = x+ 1
        print(x)
        return x

def test_answer():
    s = Sample()
    a =4
    assert s.inc(a) == 5
