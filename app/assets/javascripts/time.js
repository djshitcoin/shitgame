// Simulate Rails' Time class
window.Time = {
  get now() {
    // TODO: use server time
    return new Date().getTime() / 1000
  }
}