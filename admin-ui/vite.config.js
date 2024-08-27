import {defineConfig} from 'vite'
import vue from '@vitejs/plugin-vue'
import path from "path";
import {createSvgIconsPlugin} from "vite-plugin-svg-icons";

// https://vitejs.dev/config/
export default defineConfig({
    resolve: {
        alias: {
            "@": path.resolve(__dirname, "./src") // 相对路径别名配置，使用 @ 代替 src
        },

    },
    plugins: [
        vue(),
        createSvgIconsPlugin({
            // Specify the icon folder to be cached
            iconDirs: [path.resolve(process.cwd(), 'src/assets/icons')],
            // Specify symbolId format
            symbolId: 'icon-[dir]-[name]',
        })
    ],

    css: {
        preprocessorOptions: {
            scss: {
                javascriptEnabled: true,
                additionalData: '@import "./src/styles/variable.scss";',
            },
        },
    },
    server: {
        proxy: {
            '/api': {
                target: 'http://localhost:8080',
                changeOrigin: false
            },
            '/minio': {
                target: 'http://192.168.102.129:9000',
                changeOrigin: true,
                rewrite: (path) => path.replace(/^\/minio/, '')
            }
        }
    }
})
