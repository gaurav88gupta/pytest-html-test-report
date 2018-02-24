from .sample_code import Sample

def test_answer():
    s = Sample()
    a =4
    assert s.inc(a) == 5
