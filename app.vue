<script setup lang="ts">
const version = 2 + 1
const date = new Date()
</script>

<template>
  <div class="hello">
    Hello Nuxt {{ version }}, on Cloud Run at {{ date }}
  </div>
</template>

<style scoped>
.hello {
  font-family: Arial, Helvetica, sans-serif;
  font-size: 3rem;
  padding: 2rem;
}
</style>
