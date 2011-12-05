package hr.codingdojo.puls.gol.mstipanov;

import hr.codingdojo.puls.gol.mstipanov.ui.GameOfLifePresenter;

import java.util.Random;

/**
 * @author mstipanov
 * @since 04.12.11. 19:15
 */
public class GameOfLifeController {
    private static final int MAX = 100;

    private GameOfLifePresenter gameOfLifePresenter;
    private Random random = new Random();
    private Cell[][] cells;

    public void next() {
        Cell[][] newCells = new Cell[MAX][MAX];

        for (int y = 0; y < newCells.length; y++) {
            for (int x = 0; x < newCells[y].length; x++) {
                Cell cell = new Cell(x, y);
                cell.setAlive(getCells()[x][y].isAlive());
                cell.setAlive(getsToLive(cell));

                newCells[x][y] = cell;
            }
        }

        this.cells = newCells;
        gameOfLifePresenter.draw(this.cells);
    }

    private boolean getsToLive(Cell cell) {

        int x = cell.getX();
        int y = cell.getY();

        int liveNeighbours = 0;
        liveNeighbours += isAlive(x - 1, y - 1);
        liveNeighbours += isAlive(x - 1, y);
        liveNeighbours += isAlive(x - 1, y + 1);
        liveNeighbours += isAlive(x, y - 1);
        liveNeighbours += isAlive(x, y + 1);
        liveNeighbours += isAlive(x + 1, y - 1);
        liveNeighbours += isAlive(x + 1, y);
        liveNeighbours += isAlive(x + 1, y + 1);

        // 1. Any live cell with fewer than two live neighbours dies, as if caused by under-population:
        if (cell.isAlive() && liveNeighbours < 2)
            return false;

        // 2. Any live cell with two or three live neighbours lives on to the next generation.
        if (cell.isAlive() && (liveNeighbours == 2 || liveNeighbours == 3))
            return true;

        // 3. Any live cell with more than three live neighbours dies, as if by overcrowding.
        if (cell.isAlive() && liveNeighbours > 3)
            return false;

        // 4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.
        if (!cell.isAlive() && liveNeighbours == 3)
            return true;

        return false;
    }

    private int isAlive(int x, int y) {
        if (x < 0 || y < 0 || x >= MAX || y >= MAX)
            return 0;

        Cell cell = cells[x][y];
        return cell.isAlive() ? 1 : 0;
    }

    public void clear() {
        cells = null;
        gameOfLifePresenter.draw(getCells());
    }

    private Cell[][] getCells() {
        if (null != cells) {
            return cells;
        }

        cells = new Cell[MAX][MAX];
        for (int y = 0; y < cells.length; y++) {
            for (int x = 0; x < cells[y].length; x++) {
                Cell cell = new Cell(x, y);
                cell.setAlive(random.nextInt(100) >= 70);

                cells[x][y] = cell;
            }
        }

        return cells;
    }

    public void setGameOfLifePresenter(GameOfLifePresenter gameOfLifePresenter) {
        this.gameOfLifePresenter = gameOfLifePresenter;
    }

}
