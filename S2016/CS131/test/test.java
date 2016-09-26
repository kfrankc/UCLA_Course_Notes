import java.util.*;

    interface Set {
	boolean contains(String s);
	void add(String s);
    }

// an implementation of methods described above
class ListSet implements Set {
    // protected: this class and subclasses can have access to it
    protected List<String> elems = 
        new LinkedList<String>();

    public boolean contains(String s) {
        return elems.contains(s);
    }

    public void add(String s) {
        if(this.contains(s))
            return;
        else
            elems.add(s);
    }
}

class Client {
    void m(Set s) {
        if (s.contains("hi"))
            s.add("bye");
    }
}
