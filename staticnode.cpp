namespace node {
  int Start(int argc, char *argv[]);
};

extern "C" {
  int call_node() {
    char **argv = new char *[3];
    argv[0] = "./staticnode";
    argv[1] = "-e";
    argv[2] = "console.log('hello from nodejs world')";
    return node::Start(3, argv);
  }
}

int main() {
  return call_node();
}
