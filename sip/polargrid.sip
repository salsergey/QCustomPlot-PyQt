/** PyQt5 binding for QCustomPlot v2.1.1
 *
 *  Authors: Sergey Salnikov
 *  License: MIT
 *
 *  QCustomPlot author: Emanuel Eichhammer
 *  QCustomPlot Website/Contact: http://www.qcustomplot.com
 */


class QCPPolarGrid : public QCPLayerable
{
%TypeHeaderCode
#include <qcustomplot.h>
%End
public:
  enum GridType { gtAngular = 0x01 ///<
                  ,gtRadial = 0x02 ///<
                  ,gtAll    = 0xFF ///<
                  ,gtNone   = 0x00 ///<
                };
  typedef QFlags<QCPPolarGrid::GridType> GridTypes;

  explicit QCPPolarGrid(QCPPolarAxisAngular *parentAxis /TransferThis/);

  // getters:
  QCPPolarAxisRadial *radialAxis() const;
  GridTypes type() const;
  GridTypes subGridType() const;
  bool antialiasedSubGrid() const;
  bool antialiasedZeroLine() const;
  QPen angularPen() const;
  QPen angularSubGridPen() const;
  QPen radialPen() const;
  QPen radialSubGridPen() const;
  QPen radialZeroLinePen() const;

  // setters:
  void setRadialAxis(QCPPolarAxisRadial *axis);
  void setType(GridTypes type);
  void setSubGridType(GridTypes type);
  void setAntialiasedSubGrid(bool enabled);
  void setAntialiasedZeroLine(bool enabled);
  void setAngularPen(const QPen &pen);
  void setAngularSubGridPen(const QPen &pen);
  void setRadialPen(const QPen &pen);
  void setRadialSubGridPen(const QPen &pen);
  void setRadialZeroLinePen(const QPen &pen);

protected:
  // reimplemented virtual methods:
  virtual void applyDefaultAntialiasingHint(QCPPainter *painter) const;
  virtual void draw(QCPPainter *painter);

  // non-virtual methods:
  void drawRadialGrid(QCPPainter *painter, const QPointF &center, const QVector<double> &coords, const QPen &pen, const QPen &zeroPen=Qt::NoPen);
  void drawAngularGrid(QCPPainter *painter, const QPointF &center, double radius, const QVector<QPointF> &ticksCosSin, const QPen &pen);
};

QFlags<QCPPolarGrid::GridType> operator|(QCPPolarGrid::GridType f1, QFlags<QCPPolarGrid::GridType> f2);
QFlags<QCPPolarGrid::GridType> operator&(QCPPolarGrid::GridType f1, QFlags<QCPPolarGrid::GridType> f2);
