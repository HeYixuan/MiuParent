package org.igetwell.common.utils;


import java.util.Scanner;

public class BinaryAlgorithmUtils {

    public static int n = 0, m = 0;  //二分图的左边和右边顶点数目
    /*
     * 参数map：给定的二分图，map[i][j]等于1表示i到j连通，为0则表示不连通
     * 参数linked：linked[i] = u表示顶点i与顶点u连接
     * 参数start：当前start顶点出发，寻找增广路径
     * 函数功能：如果能够找到已顶点start开始的增广路径返回true，否则返回false
     */
    public boolean dfs(int[][] map, boolean[] used, int[] linked, int start) {
        for(int i = 0;i < m;i++) {
            if(used[i] == false && map[start][i] == 1) {
                used[i] = true;
                if(linked[i] == -1 || dfs(map, used, linked, linked[i])) {
                    linked[i] = start;
                    return true;
                }
            }
        }
        return false;
    }

    public int getMaxNum(int[][] map) {
        int count = 0;
        int[] linked = new int[m];
        for(int i = 0;i < m;i++)
            linked[i] = -1;
        for(int i = 0;i < n;i++) {
            boolean[] used = new boolean[m];  //初始化m部分顶点均为被访问
            if(dfs(map, used, linked, i))  //从顶点i出发能够得到一条增广路径
                count++;
        }
        return count;
    }

    public static void main(String[] args) {
        BinaryAlgorithmUtils test = new BinaryAlgorithmUtils();
        Scanner in = new Scanner(System.in);
        n = in.nextInt();
        m = in.nextInt();
        int[][] map = new int[n][m];
        int k = in.nextInt();     //二分图中边的数目
        for(int i = 0;i < k;i++) {
            int a = in.nextInt();   //n部分中的顶点
            int b = in.nextInt();   //m部分中顶点
            map[a][b] = 1;
        }
        System.out.println(test.getMaxNum(map));
    }
}
